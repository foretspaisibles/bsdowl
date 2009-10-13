### tex.files.mk -- Installation de fichiers pour un système TeX

# Author: Michaël Le Barbier Grünewald
# Date: Dim  9 sep 2007 17:32:25 CEST
# Lang: fr_FR.ISO8859-15

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
# 
# Copyright (C) Michaël Le Barbier Grünewald - 2006-2009
# 
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

### SYNOPSIS

# TEXFILES+= lmodern.sty
# TEXFILES+= ts1lmvtt.fd
# ...
# FORMAT = latex
# APPLICATION = lm
# TEXDIR = ${TEXMFDIR}/tex/${FORMAT}${APPLICATIONDIR}
#
# .include "tex.files.ml"


### DESCRIPTION

# Ce module se charge de l'installation de fichiers de macros dans un
# système TeX. La liste des fichiers à installer doit être émumérée
# dans TEXFILES. Le répertoire de destination est calculé à partir de
# la valeur des variables APPLICATION et FORMAT.

.include "bps.init.mk"
.include "texmf.init.mk"

MKTEXLSR?= mktexlsr
TEXGROUP?= TEXFILES
FILESGROUPS+= ${TEXGROUP}
FORMAT?= plain
APPLICATION?= misc
TEXDOCDIR?= ${TEXMFDIR}/doc/${FORMAT}${APPLICATIONDIR}
${TEXGROUP}DIR?= ${TEXMFDIR}/tex/${FORMAT}${APPLICATIONDIR}

.if defined(${TEXGROUP})&&!empty(${TEXGROUP})
post-install: post-install-mktexlsr
post-install-mktexlsr:
# L'idiome TEXMFHOME=/dev/null n'est pas très élégant, mais toutes les
# implémentations de la commande env ne supportent pas l'option `u'
# pour retirer une liaison de l'environnement.
.if ${UID} == 0
	${ENVTOOL} TEXMFHOME='/dev/null' ${MKTEXLSR}
.else
	${MKTEXLSR}
.endif
.endif

.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `tex.files.mk'
