### bps.files.mk -- Service g�n�rique d'installation

# Auteur: Micha�l Gr�newald
# Date: Ven 10 f�v 2006 10:40:49 GMT
# Lang: fr_FR.ISO8859-15

# $Id$

# BSDMake Pall�s Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pall�s Scripts
# 
# Copyright (C) Micha�l Le Barbier Gr�newald - 2006-2009
# 
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# TYPE1+= file1.type1
# TYPE1+= file2.type1
# TYPE2 = file.type
#
# TYPE1MODE.file1.type1 = 444
# TYPE1NAME.file2.type1 = fancyname
#
# FILESGROUPS =	TYPE1 TYPE2
# TYPE1OWN = owner
# TYPE1GRP = group
# TYPE1DIR = ${X11PREFIX}/directory		# Will respect ${DESTDIR}
# TYPE1MODE = 400
#
# .include "bps.init.mk"
# .include "bps.files.mk"
# .include "bps.usertarget.mk"


### DESCRIPTION

# Le module `bps.files.mk' propose une proc�dure g�n�rique
# d'installation pour les modules clients.
#
# Le module `bps.files.mk' d�finit une notion de groupe d'objets,
# chaque groupe d'objet correspond � un ensemble de param�tres pour
# l'installation, soit l'emplacement, le propri�taire les droits
# d'acc�s et le nom; et � une liste d'objets. Pour chaque objet membre
# d'un groupe, des param�tres individuels peuvent �tres d�finis
# (cf. PARAM�TRES INDIVIDUELS infra).
#
# Le module `bps.files.mk' d�finit encore des cibles/proc�dures
# `buildfiles' `installdirs' et `installfiles' � moins que celles-ci
# ne soient d�j� d�finies par le client. Ceci permet au client
# d'utiliser des m�canismes sp�cifiques pour r�aliser ces t�ches
# lorsque les actions propos�es par le module `bps.files.mk' se
# r�v�lent inappropri�es.
#
# Le module `bps.files.mk' compl�te le graphe des d�pendances en
# affirmant que `buildfiles' est un pr�requis pour `all' et
# `installfiles'. Le module tient �galement compte des
# cibles/proc�dures preinstall et postinstall lorsqu'elles existent.

# Nota: ce fichier est d�riv� de bsd.files.mk, distribu� avec le
#  syst�me FreeBSD.


#
# Description des variables
#

# FILESGROUPS
#
#  �num�ration des groupes de fichiers r�clamant la prise en charge de
#  leur installation par le module `bps.files.mk'.


#
# Param�tres individuels
#

# Les param�tres de la proc�dure d'installation du fichier '${file}'
# appartenant au groupe '${group}' sont d�crites ici.

# ${group}DIR.${file:T}
#
#  Le dossier d'installation pour ${file}, relativement �
#  ${DESTDIR}. Si ce dossier n'existe sa cr�ation est r�clam�e par la
#  cible 'installdirs'.
#
#  La valeur implicite pour cette variable est ${group}DIR.

# ${group}NAME.${file:T}
#
#  Le nom d'installation pour ${file}, si celui-ci est diff�rent de
#  celui de ${file}.
#
#  La valeur implicite pour cette variable est ${group}NAME. Remarquons
#  que si ${group}NAME est d�finie, alors tous les fichiers membres du
#  groupe ${group} sont install�s au m�me emplacement; on ne
#  positionne donc la variable ${group}NAME que lorsque ce groupe ne
#  peut compter qu'un seul membre.

# ${group}OWN.${file:T}
#
#  Le propri�taire de ${file:T}.
#
#  La valeur implicite pour cette variable est ${group}OWN.

# ${group}GRP.${file:T}
#
#  Le groupe propri�taire de ${file:T}.
#
#  La valeur implicite pour cette variable est ${group}GRP.

# ${group}MODE.${file:T}
#
#  Le mode d'acc�s de ${file:T}. Voir chmod(2).
#
#  La valeur implicite pour cette variable est ${group}MODE.


#
# D�finir de nouveaux groupes
#

# D�finir de nouveaux groupes est tr�s simple, comme le montre le
# petit exemple suivant.
#
# Pour cr�er un groupe SCRIPT, on reporte les d�clarations suivantes
# dans un fichier de directives:
#
#   FILESGROUPS+= SCRIPT
#   SCRIPTDIR?= ${BINDIR}
#   SCRIPTOWN?= ${BINOWN}
#   SCRIPTGRP?= ${BINGRP}
#   SCRIPTMODE?= ${BINMODE}
#
# On peut bien entendu initialiser � sa guise les param�tres
# d'installation pour le groupe SCRIPT, le choix fait ici donne
# cependant un exemple r�aliste.


### IMPL�MENTATION

.if !target(__<bps.files.mk>__)
__<bps.files.mk>__:

.if !target(__<bps.init.mk>__)
.error Module bps.files.mk require bps.init.mk for proper processing.
.endif

FILESGROUPS+= FILES BIN DOC SHARE LIB

.include "bps.own.mk"

.if !target(buildfiles)
.for group in ${FILESGROUPS}
buildfiles: ${${group}}
.endfor
.endif

do-build: buildfiles
do-install: installdirs
do-install: installfiles

## PROC�DURE D'INSTALLATION

# La proc�dure d'installation est situ�e avant le calcul des variables
# ${_${group}_INSTALL.${file:T}} pour d�terminer correctement la liste
# des r�pertoires devant �tre cr�es, � partir des variables GROUPDIR
# et GROUPDIR.specialisation.

.if !target(installfiles)
installfiles:
.PHONY: installfiles
.for group in ${FILESGROUPS}
.if defined(${group}) && !empty(${group})
installfiles: installfiles_${group:L}
.PHONY: installfiles_${group:L}
installfiles_${group:L}:
.for file in ${${group}}
installfiles_${group:L}: installfiles_${group:L}_${file:T}
installfiles_${group:L}_${file:T}: ${file}
	${_${group}_INSTALL.${file:T}}
.PHONY: installfiles_${group:L}_${file:T}
.endfor #file in ${${group}}
.endif #defined(${group})&&!empty(${group})
.endfor #group in ${FILESGROUPS}
.endif #!target(installfiles)

.if !target(installdirs)
installdirs:
.for group in ${FILESGROUPS}
.if defined(${group}) && !empty(${group})
	${INSTALL_DIR} ${DESTDIR}${${group}DIR}
.for item in ${${group}}
.if defined(${group}DIR.${item:T})&&!empty(${group}DIR.${item:T})
	${INSTALL_DIR} ${DESTDIR}${${group}DIR.${item:T}}
.endif
.endfor
.endif #defined(${group})&&!empty(${group})
.endfor #group in ${FILESGROUPS}
.endif #!target(installdirs)

installfiles: buildfiles


## CALCUL DES PARAM�TRES D'INSTALLATION

.for group in ${FILESGROUPS}
.if defined(${group}) && !empty(${group})
${group}OWN?=	${SHAREOWN}
${group}GRP?=	${SHAREGRP}
${group}MODE?=	${SHAREMODE}
${group}DIR?=	${SHAREDIR}
# Nota: le module bsd.files.mk propose BINDIR comme r�pertoire
#  implicite pour l'installation.
.for file in ${${group}}
.for record in DIR OWN GRP MODE
${group}${record}.${file:T}?=${${group}${record}}
.endfor
.if defined(${group}NAME)
${group}NAME.${file:T}?=${${group}NAME}
.endif
.if !defined(_${group}_INSTALL.${file:T})
_${group}_INSTALL.${file:T}=${INSTALL}\
-o ${${group}OWN.${file:T}}\
-g ${${group}GRP.${file:T}}\
-m ${${group}MODE.${file:T}}\
${.ALLSRC}
.if defined(${group}NAME.${file:T})
_${group}_INSTALL.${file:T}+=\
${DESTDIR}${${group}DIR.${file:T}}/${${group}NAME.${file:T}}
.else
_${group}_INSTALL.${file:T}+=\
${DESTDIR}${${group}DIR.${file:T}}
.endif
.endif
.endfor #file in ${${group}}
.endif #defined(${group})&&!empty(${group})
.endfor #group in ${FILESGROUPS}

.endif #!target(__<bps.files.mk>__)

### End of file `bps.files.mk'
