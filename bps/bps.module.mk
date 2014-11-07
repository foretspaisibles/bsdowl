### bps.module.mk -- Take in account other modules of the project

# Author: Michael Grünewald
# Date: Fri Nov  7 14:58:12 CET 2014

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

# Variables:
#
#  MODULE [not set, exported]
#    The list of modules in our software package
#
#    It is customary to define MODULE at the package level, but this
#    is not an obligation. In fact, it is possible to define MODULE at
#    the module level to exercise a fine-grained control over the
#    other modules that can be seen from a given module.
#
#
#  _MODULE_LIST
#    The list of module types used in our software package
#
#
#  _MODULE_${module}_ARGS
#    The list of paths holding a module of type ${module}

.if !target(__<bps.init.mk>__)
.error bps.module.mk cannot be included directly.
.endif

.if !target(__<bps.module.mk>__)
__<bps.module.mk>__:

.if defined(MODULE)
_MODULE_LIST=		${MODULE:C/\:.*//:u}
.for module in ${_MODULE_LIST}
_MODULE_${module}_ARGS:=${MODULE:M${module}\:*:C/^[^\:]*(\:|\$)//:S/,/ /g}
.endfor
.endif

.endif # !target(__<bps.module.mk>__)


.if !defined(display-module)
display-module: .PHONY
	${INFO} 'Display module information'
.for displayvar in MODULE _MODULE_LIST
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.for module in ${_MODULE_LIST}
	${MESG} "_MODULE_${module}_ARGS=${_MODULE_${module}_ARGS}"
.endfor
.endif

### End of file `bps.module.mk'
