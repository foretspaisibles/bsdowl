### bps.subdir.mk -- Manage subdirectories

# Author: Michael Grünewald
# Date: Fri Feb 10 2006 16:24:23 GMT

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

# SUBDIR+=		library
# SUBDIR+=		program
# SUBDIR+=		manual
#
# .include "bps.subdir.mk"


### DESCRIPTION

# Delegate targets enumerated by the variable _SUBDIR_TARGET to the
# directories list by the variable SUBDIR. This implements an
# aggregate pattern.
#
# The logic is as follows:
# - for each target in _SUBDIR_TARGET, a do-${target}-subdir target is
#   created, effectively descending in each subdirs and doing
#   ${target}.
# - for each target in _SUBDIR_TARGET, if no target ${target} has been
#   defined and if credential switch has not been required for
#   ${target}, a rule with an empty recipe and depending on
#   do-${target}-subdir is created for ${target}.
# - for each directory in ${SUBDIR} a ${directory} target is created,
#   requiring to make all in this subdirectory.


# Variables:
#
#
#  USE_SUBDIR [yes if SUBDIR is set, no otherwise]
#   Flag controlling the use of the subdir facility
#
#
#  SUBDIR
#   Directories in the aggregate
#
#
#  _SUBDIR_TARGET [${_MAKE_USERTARGET}]
#   Targets which are delegated
#
#
#  _SUBDIR_EXPORT
#   Variables which are exported to subdirectories
#
#
#  _SUBDIR_PREFIX [controlled by us]
#   The current subdirectory we are in


### IMPLEMENTATION

.include "bps.init.mk"
.include "bps.credentials.mk"

.if !target(__<bps.subdir.mk>__)
__<bps.subdir.mk>__:

_SUBDIR_TARGET+= ${_MAKE_USERTARGET}
_SUBDIR_PREFIX?=

.if defined(SUBDIR) && !empty(SUBDIR)
USE_SUBDIR?= yes
.else
USE_SUBDIR?= no
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

.if defined(_SUBDIR_TARGET)&&!empty(_SUBDIR_TARGET)
.for target in ${_SUBDIR_TARGET}
do-${target}-subdir: _SUBDIR
	${NOP}
.if !target(${target}) && !target(${target}-switch-credentials)
${target}: do-${target}-subdir
.endif
.endfor
.endif

.if defined(_SUBDIR_EXPORT)&&!empty(_SUBDIR_EXPORT)
.for export in ${_SUBDIR_EXPORT}
.if empty(.MAKEFLAGS:M${export}=*)&&defined(${export})
.MAKEFLAGS: ${export}="${${export}}"
.endif
.endfor
.endif

.endif # ${USE_SUBDIR} == yes
.endif #!target(__<bps.subdir.mk>__)

.include "bps.clean.mk"

### End of file `bps.subdir.mk'
