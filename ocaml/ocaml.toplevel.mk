### ocaml.toplevel.mk -- Building custom toplevels

# Author: Michael Grünewald
# Date: Sun Jun 16 13:54:55 CEST 2013

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

# TOPLEVEL=		toplevel
# SRCS=			initialize_toplevel.ml
# LIBS=			unix
# LIBS+=		str
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


### IMPLEMENTATION

THISMODULE=		ocaml.toplevel
PRODUCT=		${TOPLEVEL}
_PACKAGE_CANDIDATE=	${TOPLEVEL}

.include "ocaml.init.mk"


.if !defined(TOPLEVEL)||empty(TOPLEVEL)
.error The ocaml.toplevel.mk module expects you to set the TOPLEVEL variable to a sensible value.
.endif

TOPLEVEL_CUSTOM?= no
TOPLEVEL_COPT?=
TOPLEVEL_CLIB?=

OCAMLMKTOP?=ocamlmktop

_TOPLEVEL_FLAGS=-custom

#
# Determining toplevel flags
#

.if defined(TOPLEVEL_COPT)&&!empty(TOPLEVEL_COPT)
TOPLEVEL_CUSTOM=yes
.endif

.if defined(TOPLEVEL_CLIB)&&!empty(TOPLEVEL_CLIB)
TOPLEVEL_CUSTOM=yes
.endif

.if ${TOPLEVEL_CUSTOM} == yes
_TOPLEVEL_FLAGS+=-custom
.endif

.if defined(TOPLEVEL_COPT)&&!empty(TOPLEVEL_COPT)
.for item in ${TOPLEVEL_COPT}
_TOPLEVEL_FLAGS+=-ccopt ${item}
.endfor
.endif

.if defined(TOPLEVEL_CLIB)&&!empty(TOPLEVEL_CLIB)
.for item in ${TOPLEVEL_CLIB}
_TOPLEVEL_FLAGS+=-cclib -l${item}
.endfor
.endif

.if defined(DIRS)&&!empty(DIRS)
.for item in ${DIRS}
_TOPLEVEL_FLAGS+=-I ${item}
.endfor
.endif


.if !defined(_OCAML_COMPILE_NATIVE_ONLY)

.for file in ${SRCS}
_OCAML_CMO+= ${file:.ml=.cmo}
${TOPLEVEL}: ${file:.ml=.cmo}
.endfor

.for file in ${LIBS}
${TOPLEVEL}: ${file:=.cma}
.endfor

${TOPLEVEL}:
	${OCAMLMKTOP} ${_TOPLEVEL_FLAGS} -o ${.TARGET} ${.ALLSRC}

CLEANFILES+=    ${TOPLEVEL}
BIN+=           ${TOPLEVEL}

.else
${TOPLEVEL}: .PHONY
	${INFO} Not building toplevel ${.TARGET} in native-only mode
.endif

.include "ocaml.main.mk"
.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `ocaml.odoc.mk'
