### langc.prog.mk -- Prepare C programs

# Author: Michael Grünewald
# Date: Fri Nov  7 08:51:01 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


### SYNOPSIS

### DESCRIPTION

# Variables:
#
#
#  PROGRAM [not set]
#   Name of the program
#
#   This can actually be a list of programs.  In this case the SRCS
#   variables holds source files that will be compiled and linked to
#   all programs and for each `program` the variable `SRCS.program`
#   should specify files that will only be compiled and linked in
#   `program`.
#
#   If PACKAGE is not defined, it will be guessed from PROGRAM if this
#   is a single word or from the last component of SRCDIR otherwise.
#
#
#  SRCS [not set]
#    Files that must be compiled and linked in the program
#
#    It can list implementation files, header files, lexer and
#    parser definitions.
#
#    Note that listing header files in the sources is usually
#    superfluous because mkdep(1) can be used to compute dependencies.
#
#
#  LIBS [not set]
#    Libraries that must be linked in the program
#
#
#  DIRS [not set]
#    Directories that are searched for libraries or objects
#
#
#  CC
#    The compiler to use.
#
#
#  CFLAGS
#    Options passed to the compiler and the linker.
#
#
#  LDFLAGS
#    Options passed to the linker.
#
#
#  LDADD
#    Extra arguments for the linker.
#
#
#  BINOWN, BINGRP, BINMODE, BINDIR, BINNAME
#   Parameters of the program installation
#
#   See `bps.files.mk` for a closer description of these variables.
#
#
#  USES [not set]
#    Supported options are debug and profile
#
#
#  MODULE [not set]
#    The list of modules in our software package


THISMODULE=		langc.prog

.if defined(PROG)&&!empty(PROG)
PROGRAM?=		${PROG}
.endif

.if !defined(PROGRAM)||empty(PROGRAM)
.error The langc.prog.mk module expects you to set the PROGRAM or the PROG variable to a sensible value.
.endif

PRODUCT=		${PROGRAM}
_PACKAGE_CANDIDATE=	${PROGRAM}

.include "langc.init.mk"


#
# Prepare manual pages
#

.for program in ${PROGRAM}
_MAN_AUTO+=		${program}.1
_MAN_AUTO+=		${program}.8
.endfor


#
# Prepare source lists for each program
#

.for program in ${PROGRAM}
_LANGC_SRCS+=		SRCS.${program:T}

.if !defined(SRCS.${program:T})
.if defined(SRCS)
SRCS.${program:T}=	${SRCS}
.endif
.if exists(${program}.c)&&empty(SRCS.${program:T}:M${program}.c)
SRCS.${program:T}+=	${program}.c
.endif
.endif
.endfor


#
# Prepare library lists for each program
#

.for program in ${PROGRAM}
_LANGC_LIBS+=		LIBS.${program:T}
.if defined(LIBS)&&!empty(LIBS)
LIBS.${program:T}?=	${LIBS}
.endif
.endfor


#
# Prepare object lists for each program
#

.for program in ${PROGRAM}
_LANGC_OBJS+=		OBJS.${program:T}
.if !defined(OBJS.${program:T})
OBJS.${program:T}=	${SRCS.${program:T}:N*.h:C/\.[clys]$/.o/}
.endif
.if !empty(OBJS.${program:T}:N*.o)
.error Do not know what to do with ${OBJS.${program:T}:N*.o}\
			when preparing ${program}.
.endif
.endfor


#
# Register programs for installation and cleaning
#

.for program in ${PROGRAM}
BIN+=			${program}
CLEANFILES+=		${program}
CLEANFILES+=		${OBJS.${program:T}}
.endfor


#
# Prepare compilation for each program
#

.for program in ${PROGRAM}
${program}: ${OBJS.${program:T}}
${program}: ${LIBS.${program:T}:S@^@lib@:S@$@.a@}
${program}:
	${CCLINKTOOL} -o ${.TARGET} ${.ALLSRC:N*.h} ${LDADD}
.endfor


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

### End of file `langc.prog.mk'
