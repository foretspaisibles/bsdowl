### ocaml.odoc.mk -- Interface simple avec OCamldoc

# Author: Michael Grünewald
# Date: dim 16 jui 2013 13:54:55 CEST

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# This simple interface with ocamlmktop allows you produce toplevels.

# TOPLEVEL = toplevel
# SRCS = initialize_toplevel.ml
# LIBS = unix
# LIBS+= str
#
# .include "ocaml.odoc.mk"


### DESCRIPTION

# Targets:
#
# do-build-toplevel
# do-install-toplevel
# do-clean-toplevel

# Variables:
#
#
# TOPLEVEL
#   UNIX file name of the generated toplevel
#
#
# SEARCHES
#   Lookup path for object files
#
#   Relative paths are interpreted from ${.OBJDIR}.
#
#
# SRCS
#   OCaml implementation files
#
#
# LIBS
#   OCaml library files
#
#
# PACKAGES
#   OCaml findlib packages
#
#
# TOPLEVEL_CUSTOM
#   Flag governing generation of a custom toplevel
#
#
# TOPLEVEL_COPT
#   Pass the given options to the C compiler and linker
#
#   This forces TOPLEVEL_CUSTOM to yes.
#
#
# TOPLEVEL_CLIB
#   Pass the given library names to the C linker
#
#   This forces TOPLEVEL_CUSTOM to yes.


### RÉALISATION

.if !target(__<ocaml.toplevel.mk>__)
__<ocaml.toplevel.mk>__:

.include "bps.init.mk"
.include "ocaml.init.mk"


.if !defined(TOPLEVEL)||empty(TOPLEVEL)
.error The ocaml.toplevel.mk module expects you to set the TOPLEVEL variable to a sensible value.
.endif

TOPLEVEL_CUSTOM?= no
TOPLEVEL_COPT?=
TOPLEVEL_CLIB?=

OCAMLMKTOP?= ocamlmktop

_TOPLEVEL_FLAGS=-custom -linkall -dllpath-all -linkpkg

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

.if defined(PACKAGES)&&!empty(PACKAGES)
_TOPLEVEL_FLAGS+= -package "${PACKAGES}"
.endif

.if defined(SEARCHES)&&!empty(SEARCHES)
.for item in ${SEARCHES}
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
	${OCAMLMKTOP} ${_TOPLEVEL_FLAGS} ${.ALLSRC} -o ${.TARGET}

CLEANFILES+=    ${TOPLEVEL}
BIN+=           ${TOPLEVEL}

.else
${TOPLEVEL}:
	${DONADA}
.endif

.include "ocaml.main.mk"
.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

.endif # !target(__<ocaml.toplevel.mk>__)

### End of file `ocaml.odoc.mk'
