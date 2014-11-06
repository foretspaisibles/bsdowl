### bps.objdir.mk -- Path to the directory where the targets are built

# Author: Michael Grünewald
# Date: Sat 15 Mar 2008 20:51:30 CET

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


### DESCRIPTION

# The BSD Make program will chdir(2) to the `.OBJDIR` before executing
# any targets and each child process starts with that as its current
# working directory.
#
# The build system can then be configured to build targets in a
# directory distinct from sources and dependent of the current
# build architecture and configuration.


### VARIABLES

# MAKEOBJDIRPREFIX [not set]
# MAKEOBJDIR [not set]
# USE_OBJDIR

### TARGETS

# do-obj

### IMPLEMENTATION

.if !target(__<bps.init.mk>__)
.error bps.objdir.mk cannot be included directly.
.endif

.if !target(__<bps.objdir.mk>__)
__<bps.objdir.mk>__:

#
# Verify MAKEOBJDIRPREFIX and MAKEOBJDIR
#

# The variables MAKEOBJDIRPREFIX and MAKEOBJDIR can be set in the
# environment or on the command line but should not be set in a file.
# If one these variables is set in a file, we terminate with an
# appropriate error message.

_MAKE_CHECKOBJDIR=	${ENVTOOL} -i PATH=${PATH} ${MAKE} -f /dev/null
_MAKE_OBJDIRPREFIX!=	${_MAKE_CHECKOBJDIR} -V MAKEOBJDIRPREFIX
_MAKE_OBJDIR!=		${_MAKE_CHECKOBJDIR} -V MAKEOBJDIR

.if !empty(_MAKE_OBJDIRPREFIX)
.error MAKEOBJDIRPREFIX can be set in environment or as a command-line\
 variable but not as a global variable.
.endif

.if !empty(_MAKE_OBJDIR)
.error MAKEOBJDIR can be set in environment or as a command-line\
 variable but not as a global variable.
.endif

.undef _MAKE_OBJDIRPREFIX
.undef _MAKE_OBJDIR
.undef _MAKE_CHECKOBJDIR


#
# Initialisation
#

.if defined(MAKEOBJDIR)||defined(MAKEOBJDIRPREFIX)
USE_OBJDIR?=yes
.else
USE_OBJDIR?=no
.endif

#
# User targets
#
.if ${USE_OBJDIR} == yes

.if !target(do-obj)
do-obj:
.if defined(MAKEOBJDIRPREFIX)
	${INSTALL_DIR} ${MAKEOBJDIRPREFIX}/${.CURDIR}
.elif defined(MAKEOBJDIR)
	${INSTALL_DIR} ${MAKEOBJDIR}
.endif
.endif

.if ${.OBJDIR} != ${.CURDIR}
distclean:
	@rm -Rf ${.OBJDIR}
.endif
.else # USE_OBJDIR == no
obj:
	${NOP}
.endif

.endif # !target(__<bps.objdir.mk>__)


.if !target(display-objdir)
display-objdir:
	${INFO} 'Display objdir information'
.for displayvar in .CURDIR .OBJDIR USE_OBJDIR MAKEOBJDIR MAKEOBJDIRPREFIX
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.endif

### End of file `bps.objdir.mk'
