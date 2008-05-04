### bps.credentials.mk -- Autorisation administrateur modules `make'.

# Author: Michaël Grünewald
# Date: Sam 29 mar 2008 16:05:16 CET
# Lang: fr_FR.ISO8859-15

# $Id$

# Copyright (c) 2006, 2007, 2008, Michaël Grünewald
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

# USE_SWITCH_CREDENTIALS=yes
# .include "bps.credentials.mk"


### DESCRIPTION

# Propose d'utiliser `su' pour traiter la cible `install'.


### INTERFACE

### DÉFINITIONS

.if !target(__<bps.credentials.mk>__)
__<bps.credentials.mk>__:

### VARIABLES

USE_SWITCH_CREDENTIALS?= yes

_SWITCH_CREDENTIALS_TARGETS?=

# On ajoute la cible `install' lorsque l'utilisateur courant n'est pas
# autorisé à écrire sous ${DESTDIR}/${PREFIX}.

_SWITCH_CREDENTIALS.install!= if [ ! -w ${DESTDIR}/${PREFIX} ]; then echo install; fi

.if !empty(_SWITCH_CREDENTIALS.install)
_SWITCH_CREDENTIALS_TARGETS+= ${_SWITCH_CREDENTIALS.install}
.endif


### PSEUDO COMMANDES

ID?= /usr/bin/id
SU?= /usr/bin/su

.if !defined(UID)
UID!= ${ID} -u
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
