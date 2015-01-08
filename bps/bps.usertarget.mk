### bps.usertarget.mk -- Common build targets

# Author: Michael Grünewald
# Date: Sat Jul  7 09:59:15 CEST 2007

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

# _MAKE_USERTARGET=	configure depend build doc all install
# _MAKE_USERTARGET+=	clean distclean realclean update
# _MAKE_ALLSUBTARGET=	configure depend build doc
#
# .include "bps.usertarget.mk"


### DESCRIPTION

# Provide recipes and standard hooks for each of the targets
# enumerated by _MAKE_USER_TARGET.
#
# Define an all target, diverting the execution flow to the targets
# enumerated by _MAKE_ALLSUBTARGET.

# Variables:
#
#  _MAKE_USERTARGET [set by bps.init.mk]
#   The list of targets which are operated on
#
#   After reading this file, for any ${target} in _MAKE_USERTARGET
#   which does not exist yet:
#     1. If they exist {pre,do,post}-${target} are added to the dependencies
#        of ${target}
#     2. An empty definition of ${target} is provided.
#
#
#  _MAKE_ALLSUBTARGET
#   The list of targets subsumed by the target all


.if !target(__<bps.usertarget.mk>__)
__<bps.usertarget.mk>__:

.PHONY:			${_MAKE_USERTARGET}


#
# Define the all target
#

.for target in ${_MAKE_ALLSUBTARGET}
do-all: do-all-${target}

do-all-${target}: .USE
	@echo ${MAKE} ${target}
	@(cd ${.CURDIR} && ${MAKE} ${target})
.endfor


#
# Add pre,do,post hooks
#

.for target in ${_MAKE_USERTARGET:Nall}
.if !target(${target})
.for prefix in pre do post
.if target(${prefix}-${target})
${target}: ${prefix}-${target}
.endif
.endfor
.endif
.endfor

.for prefix in pre do post
.if target(${prefix}-all)
all: ${prefix}-all
.endif
.endfor


#
# Empty recipes
#

.for target in ${_MAKE_USERTARGET}
.if !target(${target})
${target}:
	@: ${INFO} "Nothing to do for target ${target}"
.endif
.endfor

.endif # !target(__<bps.usertarget.mk>__)

### End of file `bps.usertarget.mk'
