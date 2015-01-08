### bps.subdir.mk -- Manage subdirectories

# Author: Michael Grünewald
# Date: Fri Feb 10 16:24:23 GMT 2006

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
# directories listed by the variable SUBDIR or _SUBDIR_LIST. This
# implements a simple aggregate pattern.
#
# The logic is as follows:
# - for each target in _SUBDIR_TARGET, a do-${target}-subdir target is
#   created, effectively descending in each subdirs and doing
#   ${target}.
# - for each target in _SUBDIR_TARGET, if no target ${target} has been
#   defined and if credential switch has not been required for
#   ${target}, a rule with an empty recipe and depending on
#   do-${target}-subdir is created for ${target}.
# - for each directory in _SUBDIR_LIST a ${directory} target is created,
#   requiring to make all in this subdirectory.


# Variables:
#
#
#  USE_SUBDIR [yes if SUBDIR is set, no otherwise]
#   Flag controlling the use of the subdir facility
#
#
#  SUBDIR [not set]
#   Directories in the aggregate
#
#
#  _SUBDIR_LIST [${SUBDIR}]
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
#  SUBDIR_PREFIX [controlled by us]
#   The current subdirectory we are in


### IMPLEMENTATION

.if !target(__<bps.init.mk>__)
.error bps.subdir.mk cannot be included directly.
.endif

.if !target(__<bps.subdir.mk>__)
__<bps.subdir.mk>__:

_SUBDIR_TARGET+= ${_MAKE_USERTARGET}
SUBDIR_PREFIX?=

.if defined(SUBDIR) && !empty(SUBDIR)
_SUBDIR_LIST?=		${SUBDIR}
.endif

.if defined(_SUBDIR_LIST) && !empty(_SUBDIR_LIST)
USE_SUBDIR?= yes
.else
USE_SUBDIR?= no
.endif

.if ${USE_SUBDIR} == yes
.PHONY: ${_SUBDIR_LIST}
_SUBDIR: .USE
.for item in ${_SUBDIR_LIST}
	${INFO} "${SUBDIR_PREFIX}${item} (${.TARGET:S/^do-//:S/-subdir$//})"
	@(cd ${.CURDIR}/${item}\
	  &&${MAKE} SUBDIR_PREFIX=${SUBDIR_PREFIX}${item}/\
	  ${.TARGET:S/^do-//:S/-subdir$//} )
.endfor

${_SUBDIR_LIST}::
	${INFO} "${.TARGET} (all)"
	@(cd ${.CURDIR}/${.TARGET}; ${MAKE} all)

.if defined(_SUBDIR_TARGET)&&!empty(_SUBDIR_TARGET)
.for target in ${_SUBDIR_TARGET}
do-${target}-subdir: _SUBDIR
	${NOP}
.if !target(${target}) && !target(${target}-switch-credentials)
.for sub in pre-${target} do-${target}-subdir do-${target} post-${target}
.if target(${sub})
${target}: ${sub}
.endif
.endfor
.ORDER: pre-${target} do-${target}-subdir do-${target} post-${target}
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

### End of file `bps.subdir.mk'
