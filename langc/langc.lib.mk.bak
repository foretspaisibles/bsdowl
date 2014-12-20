### langc.lib.mk -- Prepare C libraries

# Author: Michael Grünewald
# Date: Fri Nov  7 09:04:57 CET 2014

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
#  USES [not set]
#    Supported options are debug, profile and compile
#
#
#  MODULE [not set]
#    The list of modules in our software package
#
#
#  APIVERSION [not set]
#   The shared library API version
#
#   See LIBVERSION.
#
#
#  LIBVERSION [${APIVERSION}]
#   The shared library version
#
#   When building a shared library, a library version and an api
#   version can be used to allow several version of the same shared
#   library to be simultaneously installed.  The value LIBVERSION
#   is appended to the shared object name.  The value of APIVERSION is
#   used to build a forged name, the shared object claims to have.
#
#   Typical values have the form ${APIVERSION}.MINOR.PATCHLEVEL.
#
#
# Uses:
#
#  debug: No argument allowed
#   Build with debug symbols
#
#  profile: No argument allowed
#   Build with profiling information
#
#  compile:shared,static  At least one argument required
#   Prepare the corresponding library

THISMODULE=		langc.lib

.if !defined(LIBRARY)||empty(LIBRARY)
.error The langc.lib.mk module expects you to set the LIBRARY variable to a sensible value.
.endif

PRODUCT=		${LIBRARY}
_PACKAGE_CANDIDATE=	${LIBRARY}

.include "langc.init.mk"

_USES_compile_ARGS?=	static shared

.for product in ${PRODUCT}
PRODUCT_ARGS.${product}+=${_USES_compile_ARGS}
.endfor

.if defined(APIVERSION)
LIBVERSION?=		${APIVERSION}
.endif

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

.if ${_LANGC_SHARED_FORMAT} == elf
_LANGC_SHARED_SUFFIX=	so
.elif ${_LANGC_SHARED_FORMAT} == mach-o
_LANGC_SHARED_SUFFIX=	dylib
.else
.error ${_LANGC_SHARED_FORMAT}: Unsupported shared object format.
.endif

.if!empty(_USES_compile_ARGS:Mstatic)
LIB+=			lib${LIBRARY}.a
CLEANFILES+=		lib${LIBRARY}.a
.endif
.if!empty(_USES_compile_ARGS:Mshared)
CFLAGS+=		-fpic
.if defined(LIBVERSION)
LIB+=			lib${LIBRARY}.${_LANGC_SHARED_SUFFIX}.${LIBVERSION}
CLEANFILES+=		lib${LIBRARY}.${_LANGC_SHARED_SUFFIX}.${LIBVERSION}
.else
LIB+=			lib${LIBRARY}.${_LANGC_SHARED_SUFFIX}
CLEANFILES+=		lib${LIBRARY}.${_LANGC_SHARED_SUFFIX}
.endif
.endif
INCLUDE+=		${SRCS:M*.h}
CLEANFILES+=		${OBJS}


#
# Prepare library
#

lib${LIBRARY}.a:	${OBJS}
	${AR} ${ARFLAGS} ${.TARGET} ${.ALLSRC} ${ARADD}

.if defined(APIVERSION)&&("${APIVERSION}" != "${LIBVERSION}")
.if ${_LANGC_SHARED_FORMAT} == elf
MKSHAREDLIB+=		-Wl,-soname,lib${LIBRARY}.so.${APIVERSION}
.elif ${_LANGC_SHARED_FORMAT} == mach-o
MKSHAREDLIB+=		-Wl,-install_name,lib${LIBRARY}.dylib.${APIVERSION}
.else
.error ${_LANGC_SHARED_FORMAT}: Unsupported shared object format.
.endif
.endif

.if defined(LIBVERSION)
lib${LIBRARY}.${_LANGC_SHARED_SUFFIX}.${LIBVERSION}: ${OBJS}
.else
lib${LIBRARY}.${_LANGC_SHARED_SUFFIX}: ${OBJS}
.endif
	${MKSHAREDLIB} -o ${.TARGET} ${.ALLSRC}


#
# Display debugging information
#

.if !target(display-lib)
display-lib: .PHONY
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
