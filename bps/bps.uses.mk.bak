### bps.uses.mk -- Process module options

# Author: Michael Grünewald
# Date: Fri Nov  7 14:27:17 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

### DESCRIPTION

# Variables:
#
#  USES [not set]
#    A list of options.
#
#
#  _USES_OPTIONS
#    The list of options found in ${USES}.
#
#
#  _USES_${option}_ARGS
#    The argument for option ${option}


# Targets:
#
#   display-uses:
#     Display debug information.

.if !target(__<bps.init.mk>__)
.error bps.uses.mk cannot be included directly.
.endif

.if !target(__<bps.uses.mk>__)
__<bps.uses.mk>__:

.if defined(USES)&&!empty(USES)
_USES_OPTIONS=		${USES:C/\:.*//}
.for option in ${USES}
_USES_${option:C/\:.*//}_ARGS:=${option:C/^[^\:]*(\:|\$)//:S/,/ /g}
.endfor
.endif

.endif # !target(__<bps.uses.mk>__)

.if !defined(display-uses)
display-uses: .PHONY
	${INFO} 'Display uses information'
.for displayvar in USES _USES_OPTIONS
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.for option in ${_USES_OPTIONS}
	${MESG} "_USES_${option}_ARGS=${_USES_${option}_ARGS}"
.endfor
.endif

### End of file `bps.uses.mk'
