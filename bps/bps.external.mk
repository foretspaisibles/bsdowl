### bps.external.mk -- Take in account externals of the project

# Author: Michael Grünewald
# Date: Fri Nov  7 15:16:04 CET 2014

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

### DESCRIPTION

.if !target(__<bps.init.mk>__)
.error bps.external.mk cannot be included directly.
.endif

.if !target(__<bps.external.mk>__)
__<bps.external.mk>__:

.if defined(EXTERNAL)
_EXTERNAL_LIST=		${EXTERNAL:C/\:.*//:u}
.for external in ${_EXTERNAL_LIST}
_EXTERNAL_${external}_ARGS:=${EXTERNAL:M${external}\:*:C/^[^\:]*(\:|\$)//:S/,/ /g}
.endfor
.endif

.endif # !target(__<bps.external.mk>__)


.if !defined(display-external)
display-external: .PHONY
	${INFO} 'Display external information'
.for displayvar in EXTERNAL _EXTERNAL_LIST
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.for external in ${_EXTERNAL_LIST}
	${MESG} "_EXTERNAL_${external}_ARGS=${_EXTERNAL_${external}_ARGS}"
.endfor
.endif

### End of file `bps.external.mk'
