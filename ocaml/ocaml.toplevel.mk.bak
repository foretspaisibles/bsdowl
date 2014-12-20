### ocaml.toplevel.mk -- Building custom toplevels

# Author: Michael Grünewald
# Date: Sun Jun 16 13:54:55 CEST 2013

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

# TOPLEVEL=		toplevel
# SRCS=			initialize_toplevel.ml
#
# .include "ocaml.toplevel.mk"


### DESCRIPTION

# This simple interface to `ocamlmktop` drives the production of
# toplevels.

# Targets:
#
# do-build-toplevel
# do-install-toplevel
# do-clean-toplevel

# Variables:
#
#
#  TOPLEVEL
#   UNIX file name of the generated toplevel
#
#
#  DIRS
#   Lookup path for object files
#
#   Relative paths are interpreted from ${.OBJDIR}.
#
#
#  SRCS
#   OCaml implementation files
#
#
#  LIBS
#   OCaml library files
#
#
#  PKGS
#   OCaml findlib packages
#
#
#  TOPLEVEL_CUSTOM
#   Flag governing generation of a custom toplevel
#
#
#  TOPLEVEL_COPT
#   Pass the given options to the C compiler and linker
#
#   This forces TOPLEVEL_CUSTOM to yes.
#
#
#  TOPLEVEL_CLIB
#   Pass the given library names to the C linker
#
#   This forces TOPLEVEL_CUSTOM to yes.
#
#
#  TOPLEVEL_FLAGS
#   Flags passed to ocamlmktop


### IMPLEMENTATION

THISMODULE=		ocaml.toplevel
PRODUCT=		${TOPLEVEL}
_PACKAGE_CANDIDATE=	${TOPLEVEL}

.include "ocaml.init.mk"


.if !defined(TOPLEVEL)||empty(TOPLEVEL)
.error The ocaml.toplevel.mk module expects you to set the TOPLEVEL variable to a sensible value.
.endif

.if defined(TOPLEVEL_COPT)||defined(TOPLEVEL_CLIB)
TOPLEVEL_CUSTOM?=	yes
.elif defined(SRCS)&&!empty(SRCS:M*.c)
TOPLEVEL_CUSTOM?=	yes
.else
TOPLEVEL_CUSTOM?=	no
.endif

OCAMLMKTOP?=		ocamlmktop


#
# Determining toplevel flags
#

.if ${TOPLEVEL_CUSTOM} == yes
.if !defined(TOPLEVEL_FLAGS)||empty(TOPLEVEL_FLAGS:M-custom)
TOPLEVEL_FLAGS+=	-custom
.endif
.endif

.if defined(TOPLEVEL_COPT)&&!empty(TOPLEVEL_COPT)
.for item in ${TOPLEVEL_COPT}
TOPLEVEL_FLAGS+=	-ccopt ${item}
.endfor
.endif

.if defined(TOPLEVEL_CLIB)&&!empty(TOPLEVEL_CLIB)
.for item in ${TOPLEVEL_CLIB}
TOPLEVEL_FLAGS+=	-cclib -l${item}
.endfor
.endif

.if defined(DIRS)&&!empty(DIRS)
.for item in ${DIRS}
TOPLEVEL_FLAGS+=	-I ${item}
.endfor
.endif


.if !defined(_OCAML_COMPILE_NATIVE_ONLY)

.for file in ${SRCS:M*.ml}
_OCAML_CMO+=		${file:.ml=.cmo}
${TOPLEVEL}: ${file:.ml=.cmo}
.endfor

.for file in ${SRCS:M*.c}
${TOPLEVEL}: ${file:.c=.o}
CLEANFILES+=		${file:.c=.o}
.endfor

.if defined(SRCS)&&!empty(SRCS:M*.c)
CFLAGS+=		-I ${OCAMLROOTDIR}
.endif

.for file in ${LIBS}
${TOPLEVEL}: ${file:=.cma}
.endfor

${TOPLEVEL}:
	${OCAMLMKTOP} ${TOPLEVEL_FLAGS} -o ${.TARGET} ${.ALLSRC}

CLEANFILES+=    ${TOPLEVEL}
BIN+=           ${TOPLEVEL}

.else
${TOPLEVEL}: .PHONY
	${INFO} Not building toplevel ${.TARGET} in native-only mode
.endif

display-developer-dirs: .PHONY
.for dir in ${DIRS}
	@printf '#directory "%s";;\n' "${dir}"
.endfor

.include "ocaml.main.mk"
.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `ocaml.toplevel.mk'
