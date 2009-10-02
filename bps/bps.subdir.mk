### bps.subdir.mk -- Manage subdirectories

# Author: Michaël Le Barbier Grünewald
# Date: Ven 10 fév 2006 16:24:23 GMT
# Lang: fr_FR.ISO8859-1

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

# SUBDIR+= library
# SUBDIR+= program
# SUBDIR+= manual
#
# .include "bps.subdir.mk"


### DESCRIPTION

# Diffuse la demande de production des cibles administratives énumérées par la
# variables _SUBDIR_TARGET vers les sous-répertoires énumérés par la variable
# SUBDIR.
#
# Pour chaque cible administrative ${target}, une cible do-${target}-subdir
# est définie, la règle de production de cette cible lance le sous-traitement
# de ${target} dans les sous-répertoires énumérés dans SUBDIR.
#
# Les cibles administratives sont marquées par l'attribut `.PHONY'.
#
# À moins qu'une cible ${target}-switch-credentials existe, la cible
# do-${target}-subdir devient un prérequis de ${target}. Ce comportement
# permet l'utilsiation conjointe de ce module de directives avec le module
# `bps.credentials.mk'.


#
# Description des variables
#

# USE_SUBDIR
#
#  Drapeau de contrôle de la rediffusion des ordres de production vers les
#  sous-dossiers.
#
#  La rediffusion des ordres de production vers les sous-dossiers a lieu
#  lorsque la variable USE_SUBDIR est positionnée à `yes'. En l'absence
#  d'initialisation explicite, lorsque SUBDIR est initialisée la variable
#  USE_SUBDIR reçoit la valeur implicite `yes'.

# SUBDIR
#
#  Liste des sous-dossiers vers lesquels les ordres de production sont
#  rediffusés.

# _SUBDIR_TARGET
#
#  Liste des ordres de production devant être rediffusés.
#
#  Les ordres de production énumérés par la variable _MAKE_USERTARGET
#  (bps.usertarget.mk) sont automatiquement ajoutés à cette variable.


### IMPLÉMENTATION

.include "bps.init.mk"
.include "bps.credentials.mk"

.if !target(__<bps.subdir.mk>__)
__<bps.subdir.mk>__:

_SUBDIR_TARGET+= ${_MAKE_USERTARGET}
_SUBDIR_PREFIX?=

.if defined(SUBDIR) && !empty(SUBDIR)
USE_SUBDIR?= yes
.endif

.if ${USE_SUBDIR} == yes
.PHONY: ${SUBDIR}
_SUBDIR: .USE
.for item in ${SUBDIR}
	${INFO} "${_SUBDIR_PREFIX}${item} (${.TARGET:S/^do-//:S/-subdir$//})"
	@cd ${.CURDIR}/${item}\
	  &&${MAKE} _SUBDIR_PREFIX=${_SUBDIR_PREFIX}${item}/ ${.TARGET:S/^do-//:S/-subdir$//}
.endfor

${SUBDIR}::
	${INFO} "${.TARGET} (all)"
	@cd ${.CURDIR}/${.TARGET}; ${MAKE} all

.for target in ${_SUBDIR_TARGET}
do-${target}-subdir: _SUBDIR
	${NOP}
.if !target(${target}-switch-credentials)
${target}: do-${target}-subdir
.endif
.endfor

.endif # ${USE_SUBDIR} == yes
.endif #!target(__<bps.subdir.mk>__)

.include "bps.clean.mk"

### End of file `bps.subdir.mk'
