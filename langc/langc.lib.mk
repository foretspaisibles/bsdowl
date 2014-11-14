### langc.lib.mk -- Prepare C libraries

# Author: Michael Grünewald
# Date: Fri Nov  7 09:04:57 CET 2014

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
#  LIBRARY [not set]
#   Name of the library
#
#
#  SRCS [not set]
#    Files that must be compiled and linked in the library
#
#    It can list implementation files, header files, lexer and
#    parser definitions.
#
#    Listed header files will be installed.
#
#
#  DIRS [not set]
#    Directories that are searched for libraries or objects
#
#
#  CC [cc]
#    The compiler to use
#
#
#  CFLAGS [not set]
#    Options passed to the compiler and the linker
#
#
#  AR [ar]
#    Archiver used to prepare a library
#
#  ARFLAGS [not set]
#    Options passed to the archiver
#
#
#  ARADD [not set]
#    Extra arguments for the archiver
#
#
#  LIBOWN, LIBGRP, LIBMODE, LIBDIR, LIBNAME
#   Parameters of the library installation
#
#   See `bps.files.mk` for a closer description of these variables.
#
#
#  INCLUDEOWN, INCLUDEGRP, INCLUDEMODE, INCLUDEDIR, INCLUDENAME
#   Parameters of the include files installation
#
#   See `bps.files.mk` for a closer description of these variables.
#
#
#  WITH_DEBUG [no]
#    Build with debug symbols
#
#
#  WITH_PROFILE [no]
#   Build with profiling information
#
#
#  USES [not set]
#    Supported options are debug and profile
#
#
#  MODULE [not set]
#    The list of modules in our software package


THISMODULE=		langc.lib

.if !defined(LIBRARY)||empty(LIBRARY)
.error The langc.lib.mk module expects you to set the LIBRARY variable to a sensible value.
.endif

PRODUCT=		${LIBRARY}
_PACKAGE_CANDIDATE=	${LIBRARY}

.include "langc.init.mk"

#
# Prepare manual pages
#

_MAN_AUTO+=		lib${LIBRARY}.3


#
# Prepare list of sources
#  for langc.depend.mk
#

_LANGC_SRCS=		SRCS

#
# Prepare object lists for our library
#

.if !defined(OBJS)
OBJS=			${SRCS:N*.h:C/\.[cly]$/.o/}
.endif
.if !empty(OBJS:N*.o)
.warning Do not know what to do with ${OBJS:N*.o}\
			when preparing lib${LIBRARY}.
.endif

#
# Register programs for installation and cleaning
#

LIB+=			lib${LIBRARY}.a
INCLUDE+=		${SRCS:M*.h}
CLEANFILES+=		lib${LIBRARY}.a
CLEANFILES+=		${OBJS}


#
# Prepare library
#

lib${LIBRARY}.a:	${OBJS}
	${AR} ${ARFLAGS} ${.TARGET} ${.ALLSRC} ${ARADD}


#
# Display debugging information
#

.if !target(display-prog)
display-prog: .PHONY
	${INFO} 'Display langc program information'
.for displayvar in PROGRAM MAN SRCS LIBS DIRS MODULE EXTERNAL USES
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.for program in ${PROGRAM}
.for displayvar in SRCS.${program:T} LIBS.${program:T} OBJS.${program:T}
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.endfor
.endif

.include "langc.build.mk"
.include "langc.depend.mk"
.include "bps.man.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

### End of file `langc.lib.mk'
