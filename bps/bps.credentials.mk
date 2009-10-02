### bps.credentials.mk -- Autorisation administrateur modules `make'.

# Author: Michaël Le Barbier Grünewald
# Date: Sam 29 mar 2008 16:05:16 CET
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

# USE_SWITCH_CREDENTIALS = yes
#
# .include "bps.credentials.mk"


### DESCRIPTION

# Propose d'utiliser `su' pour traiter la cible `install' ou d'autres
# cibles énumérées dans la liste _SWITCH_CREDENTIALS_TARGETS.

#
# Description des variables
#

# USE_SWITCH_CREDENTIALS
#
#  Indique s'il faut utiliser ou non les privilèges de
#  l'administrateur pour les cibles énuméréss dans
#  _SWITCH_CREDENTIALS_TARGETS.
#
#  Les valeurs possibles sont 'yes' et 'no'.
#  La valeur implicte est 'yes'.

# _SWITCH_CREDENTIALS_TARGETS
#
#  Énumération des cibles pour lesquelles l'élévation des privlèges
#  est souhaitée.
#
#  La valeur implcite est la liste vide, sauf si l'utilisateur courant
#  n'est pas autorisé à écrire dans le dossier ${DESTDIR}${PREFIX},
#  dans ce dernier cas la valeur implicite est la liste à un élément,
#  'install'.


### IMPLÉMENTATION

.if !target(__<bps.credentials.mk>__)
__<bps.credentials.mk>__:

#
# VARIABLES
#

USE_SWITCH_CREDENTIALS?= yes

_SWITCH_CREDENTIALS_TARGETS?=

# On ajoute la cible `install' lorsque l'utilisateur courant n'est pas
# autorisé à écrire sous ${DESTDIR}${PREFIX}.

_SWITCH_CREDENTIALS.install!= if [ ! -w /${DESTDIR}${PREFIX} ]; then echo install; else echo ''; fi

.if !empty(_SWITCH_CREDENTIALS.install)
_SWITCH_CREDENTIALS_TARGETS+= ${_SWITCH_CREDENTIALS.install}
.endif


#
# Changement d'autorisation pour installer en tant que `root'
#

.if(${USE_SWITCH_CREDENTIALS} == yes)&&!(${UID} == 0)
.for target in ${_SWITCH_CREDENTIALS_TARGETS}
.if !target(${target})
${target}:: ${target}-switch-credentials
	${NOP}
${target}-switch-credentials:
	${INFO} 'Switching to root credentials for target (${target})'
	@${SU} root -c '${MAKE} ${target}'
.endif
.endfor
.endif

.endif # !target(__<bps.credentials.mk>__)

### End of file `bps.credentials.mk'
