### www.sgml.mk -- Production HTML via SGML

# Author: Michaël Le Barbier Grünewald
# Date: Jeu 13 mar 2008 21:58:28 CET
# Lang: fr_FR.ISO8859-15

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) Michaël Le Barbier Grünewald - 2009
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# Attention: il ne s'agit pas d'un système DOCBOOK!

# WWW = index.html
# SRCS = index.sgml
# SRCS+= head-css.sgml
# SRCS+= head-title.sgml
# SRCS+= body-content.sgml
# SRCS+= body-nav.sgml
#
# WWWDIR = ${WWWBASE}/subdir
#
# .include "www.sgml.mk"



#
# Description des variables
#

# WWW
#
#   Énumère les fichiers à produire à partir des sources SGML
#
#   Chaque terme a sa propre variable SRCS, et la variable SRCS
#   générale y est ajoutée.


# WWWMAIN
#
#    Nom du fichier principal
#
#    Pour produire plusieurs fichiers, il faut utiliser la forme
#    spécialisée de cette variable.


# WWWBASE
#
#   Répertoire racine du document cible (la version installée)
#
#   Lorsque cette variable a une valeur, cette valeur est transmise
#   aux sous-processus MAKE, de cette façon elle peut être utilisée
#   pour définir correctement WWWDIR.

# WWWOWN, WWWGRP, WWWMODE, WWWDIR
#
#   Paramètres de la procédure d'installation
#
#   Ces paramètres sont documentés dans le module bps.files.mk.

# INCLUDE
#
#   Énumère les entités à inclure
#
#   Il s'agit des entités de type paramètre dont la valeur doit être
#   positionnée à INCLUDE.

# SEARCH
#
#   Énumère les dossiers de recherche

# CATALOG
#
#   Énumère les catalogues à inclure pour la résolution des entités

.include "bps.init.mk"

.SUFFIXES: .sgml

WWWNORMALIZE?= osgmlnorm -d
WWWINPUT?= ascii
WWWTIDY?= tidy -q -${WWWINPUT}

.for variable in SEARCH CATALOG INCLUDE
.if defined(${variable})&&!empty(${variable})
.MAKEFLAGS: ${variable}='${${variable}}'
.else
${variable}=
.endif
.endfor

WWWNORMALIZETOOL = ${WWWNORMALIZE}
.for search in ${SEARCH}
WWWNORMALIZETOOL+= -D${search}
.PATH.sgml: ${search}
.endfor
.for catalog in ${CATALOG}
WWWNORMALIZETOOL+= -c${catalog}
.endfor
.for include in ${INCLUDE}
WWWNORMALIZETOOL+= -i${include}
.endfor

.for file in ${WWW}
.if defined(WWWMAIN)&&!empty(WWWMAIN)
WWWMAIN.${file:T} = ${WWWMAIN}
.endif
.if !defined(WWWMAIN.${file:T}) && exists(${file:.html=.sgml})
WWWMAIN.${file:T} = ${file:.html=.sgml}
.endif
.if !defined(WWWMAIN.${file:T}) || empty(WWWMAIN.${file:T})
.error "No main file for ${file}"
.endif
SRCS.${file:T}?= ${WWWMAIN.${file:T}}
.if empty(SRCS.${file:T}:M${WWWMAIN.${file:T}})
SRCS.${file:T}+= ${WWWMAIN.${file:T}}
.endif
.endfor

.if defined(SRCS)&!empty(SRCS)
.for file in ${WWW}
SRCS.${file:T}+= ${SRCS}
.endfor
.endif

.for file in ${WWW}
CLEANFILES+= ${file}
.if exists(${file}.pre)
CLEANFILES += ${file}.pre
.endif
${file}: ${SRCS.${file:T}}
	${WWWNORMALIZETOOL} ${WWWMAIN.${file:T}} | ${WWWTIDY} > ${.TARGET}.pre
	${MV} ${.TARGET}.pre ${.TARGET}
.endfor

.include "www.files.mk"

### End of file `www.files.mk'
