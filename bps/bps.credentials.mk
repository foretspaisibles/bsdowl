### bps.credentials.mk -- Credential switch

# Author: Michael Grünewald
# Date: Sat Mar 29 16:05:16 CET 2008

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2014 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# USE_SWITCH_CREDENTIALS = yes


### DESCRIPTION

# Implement a credential switch which applies to the targets
# enumerated in the _SWITCH_CREDENTIALS_TARGETS variable, e.g. install.

# Variables:
#
#  USE_SWITCH_CREDENTIALS
#   Command the use of the switch credential functionality
#
#   Possible values are 'yes' or 'no', it defaults to 'yes'.
#
#
#  _SWITCH_CREDENTIALS_TARGETS
#   List of targets needing a credential switch
#
#   It defaults to the empty list, except for the user is inable to
#   write in ${DESTDIR}${PREFIX}, in which case the install target is
#   added to this list.


### IMPLEMENTATION

.if !target(__<bps.init.mk>__)
.error bps.credentials.mk cannot be included directly.
.endif

.if !target(__<bps.credentials.mk>__)
__<bps.credentials.mk>__:

#
# Variables
#

USE_SWITCH_CREDENTIALS?= yes

_SWITCH_CREDENTIALS_TARGETS?=

# Add the `install` target if the current user is not allowed to write
# under ${DESTDIR}${PREFIX}.

_SWITCH_CREDENTIALS.install!= if [ ! -w /${DESTDIR}${PREFIX} ]; then echo install; else echo ''; fi

.if !empty(_SWITCH_CREDENTIALS.install)
_SWITCH_CREDENTIALS_TARGETS+= ${_SWITCH_CREDENTIALS.install}
.endif


#
# Credential switch
#

.if(${USE_SWITCH_CREDENTIALS} == yes)&&!(${UID} == 0)
.for target in ${_SWITCH_CREDENTIALS_TARGETS}
.if !target(${target})
${target}:: ${target}-switch-credentials
	${NOP}
${target}-switch-credentials:
	${INFO} 'Switching to root credentials for target (${target})'
.if ${_BPS_SWITCH_CREDENTIALS_STRATEGY} == su
	@${SU} root -c '${MAKE} ${target}'
.elif ${_BPS_SWITCH_CREDENTIALS_STRATEGY} == sudo
	@${SUDO} ${MAKE} UID=0 ${target}
.else
	@${MAKE} UID=0 ${target}
.endif
.endif
.endfor
.endif

.endif # !target(__<bps.credentials.mk>__)

### End of file `bps.credentials.mk'
