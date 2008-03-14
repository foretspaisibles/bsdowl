### make.files.mk -- Service générique d'installation

# Auteur: Michaël Grünewald
# Date: Ven 10 fév 2006 10:40:49 GMT
# Lang: fr_FR.ISO8859-15

# $Id$

# Copyright (c) 2008, Michaël Grünewald
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#    1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#    2. Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#
#    3. The name of the author may not be used to endorse or promote
#    products derived from this software without specific prior written
#    permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.


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
# .include "make.init.mk"
# .include "make.files.mk"
# .include "make.usertarget.mk"


### DESCRIPTION

# Le module `make.files.mk' propose une procédure générique
# d'installation pour les modules clients.
#
# Le module `make.files.mk' définit une notion de groupe d'objets,
# chaque groupe d'objet correspond à un ensemble de paramètres pour
# l'installation, soit l'emplacement, le propriétaire les droits
# d'accès et le nom; et à une liste d'objets. Pour chaque objet membre
# d'un groupe, des paramètres individuels peuvent êtres définis
# (cf. PARAMÈTRES INDIVIDUELS infra).
#
# Le module `make.files.mk' définit encore des cibles/procédures
# `buildfiles' `installdirs' et `installfiles' à moins que celles-ci
# ne soient déjà définies par le client. Ceci permet au client
# d'utiliser des mécanismes spécifiques pour réaliser ces tâches
# lorsque les actions proposées par le module `make.files.mk' se
# révèlent inappropriées.
#
# Le module `make.files.mk' complète le graphe des dépendances en
# affirmant que `buildfiles' est un prérequis pour `all' et
# `installfiles'. Le module tient également compte des
# cibles/procédures preinstall et postinstall lorsqu'elles existent.

# Nota: ce fichier est dérivé de bsd.files.mk

## PARAMÈTRES INDIVIDUELS XXX

## DÉFINIR DE NOUVEAUX GROUPES XXX

.if !target(__<make.files.mk>__)
__<make.files.mk>__:

.if !target(__<make.init.mk>__)
.error Module make.files.mk require make.init.mk for proper processing.
.endif

FILESGROUPS+= FILES BIN DOC SHARE LIB

.if !target(buildfiles)
.for group in ${FILESGROUPS}
buildfiles: ${${group}}
.endfor
.endif

do-build: buildfiles
do-install: installdirs
do-install: installfiles

## PROCÉDURE D'INSTALLATION

# La procédure d'installation est située avant le calcul des variables
# ${_${group}_INSTALL.${file:T}} pour déterminer correctement la liste
# des répertoires devant être crées, à partir des variables GROUPDIR
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
installfiles_${group:L}_${file:T}: ${file:T}
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


## CALCUL DES PARAMÈTRES D'INSTALLATION

.for group in ${FILESGROUPS}
.if defined(${group}) && !empty(${group})
${group}OWN?=	${SHAREOWN}
${group}GRP?=	${SHAREGRP}
${group}MODE?=	${SHAREMODE}
${group}DIR?=	${SHAREDIR}
# Nota: le module bsd.files.mk propose BINDIR comme répertoire
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

.endif #!target(__<make.files.mk>__)

### End of file `make.files.mk'
