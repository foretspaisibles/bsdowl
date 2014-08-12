### ocaml.build.mk -- Creating command lines for build

# Author: Michael Grünewald
# Date: Tue Apr  5 10:31:04 CEST 2005

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2005-2009, 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# _OCAML_CMO=	module1.cmo module2.cmo module3.cmo
# _OCAML_CMX=	module1.cmx module2.cmx module3.cmx
# _OCAML_CMI=	module1.cmi
# _OCAML_CMA=	library.cma
# _OCAML_CMXA=	library.cmxa
# _OCAML_CB=	prog1.byte
# _OCAML_CN=	prog1.native
#
# .include "ocaml.init.mk"
# .include "ocaml.build.mk"


### DESCRIPTION

# We compute command lines for building all the objects listed in the
# variables _OCAML_CMO, etc. listed above in the synopsis.  For each
# object, the command line looks like
#
#  ${obj}:
#	${_OCAML_BUILD.${obj:T}} ${.ALLSRC}
#
# We also write down the correct dependencies between interface and
# implementation files and provide the appropriate recipe.  It is
# necessary to tell how (not to) build the compiled implementation
# file when writing lexers and parsers.
#
# This module is intended to be included by other modules rather than
# to serve as is to the end user.

# Variables:
#
#  WITH_DEBUG
#   Build with debug symbols
#
#   Setting WITH_DEBUG to yes will add the `-g` flag to the variables
#   OCAMLCFLAGS and OCAMLLFLAGS.
#
#
#  WITH_THREADS (no)
#   Build with threads support
#
#
#  WITH_VMTHREADS (no)
#   Force VM-level scheduling of threads in byte-code programs
#
#
#  WITH_CAMLP4 (no)
#   Include the camlp4 directory during the build process
#
#
#  WITH_COMPILERLIBS (no)
#   Include the compiler libs directory during the build process
#
#
#  USE_ANNOTATE (no)
#   Generate annotate files to support use of type information in editors
#
#
#  USE_CUSTOM (yes)
#   Link byte-code programs in custome mode


### IMPLEMENTATION

# For all kind of object we define a structure holding the
# pseudo-command, the ovject list and the flags to be added.

_OCAML_CMI.cmd=	OCAMLCI
_OCAML_CMI.obj=	_OCAML_CMI
_OCAML_CMI.var=	OCAMLCIFLAGS OCAMLCFLAGS OCAMLFLAGS

_OCAML_CMO.cmd=	OCAMLCB
_OCAML_CMO.obj=	_OCAML_CMO
_OCAML_CMO.var=	OCAMLCBFLAGS OCAMLCFLAGS OCAMLFLAGS

_OCAML_CMX.cmd=	OCAMLCN
_OCAML_CMX.obj=	_OCAML_CMX
_OCAML_CMX.var=	OCAMLCNFLAGS OCAMLCFLAGS OCAMLFLAGS

_OCAML_CB.cmd=	OCAMLLB
_OCAML_CB.obj=	_OCAML_CB
_OCAML_CB.var=	OCAMLLBFLAGS OCAMLLFLAGS OCAMLFLAGS OCAMLLBADD

_OCAML_CN.cmd=	OCAMLLN
_OCAML_CN.obj=	_OCAML_CN
_OCAML_CN.var=	OCAMLLNFLAGS OCAMLLFLAGS OCAMLFLAGS OCAMLLNADD

_OCAML_CMA.cmd=	OCAMLAB
_OCAML_CMA.obj=	_OCAML_CMA
_OCAML_CMA.var=	OCAMLABFLAGS OCAMLAFLAGS OCAMLFLAGS OCAMLABADD

_OCAML_CMXA.cmd=OCAMLAN
_OCAML_CMXA.obj=_OCAML_CMXA
_OCAML_CMXA.var=OCAMLANFLAGS OCAMLAFLAGS OCAMLFLAGS OCAMLANADD

_OCAML_PKO.cmd=	OCAMLPB
_OCAML_PKO.obj=	_OCAML_PKO
_OCAML_PKO.var=	OCAMLPBFLAGS OCAMLCFLAGS OCAMLFLAGS

_OCAML_PKX.cmd=	OCAMLPN
_OCAML_PKX.obj=	_OCAML_PKX
_OCAML_PKX.var=	OCAMLPNFLAGS OCAMLCFLAGS OCAMLFLAGS

#
# Processing knobs
#

WITH_DEBUG?= no
WITH_VMTHREADS?= no
WITH_PROFILE?=no
WITH_CAMLP4?= no
WITH_COMPILERLIBS?= no

.if ${WITH_VMTHREADS} == yes
WITH_THREADS?= yes
.else
WITH_THREADS?= no
.endif

USE_ANNOTATE?= no
USE_CUSTOM?= no


.if ${WITH_DEBUG} == yes
OCAMLCFLAGS+= -g
OCAMLLFLAGS+= -g
.endif

.if ${WITH_THREADS} == yes
.if (${WITH_PROFILE} == yes)&&defined(_OCAML_COMPILE_BYTE)
.error Profiling of multithreaded byte code not supported by OCaml
.elif ${WITH_VMTHREADS} == yes
OCAMLCNFLAGS+= -threads
OCAMLCBFLAGS+= -vmthreads
.else
OCAMLCFLAGS+= -threads
.endif
.endif

.if ${WITH_CAMLP4} == yes
DIRS+= ${OCAMLROOTDIR}/camlp4
.endif

.if ${WITH_COMPILERLIBS} == yes
DIRS+= ${OCAMLROOTDIR}/compiler-libs
.endif

.if ${USE_ANNOTATE} == yes
OCAMLCFLAGS+= -annot
.endif

.if ${USE_CUSTOM} == yes
OCAMLLBFLAGS+= -custom
.endif


#
# Specialising variables
#

# We specialise variables associated to each preivously defined
# structure.  For instance, each of the native code object listed in
# _OCAML_CN gets its own specialised value for OCAMLLNFLAGS, OCAMLLFLAGS,
# OCAMLFLAGS and OCAMLLNADD (all the variables listed in _OCAML_CN.var).

.for thg in ${_OCAML_OBJECT}
.for obj in ${${${thg}.obj}}
.for var in ${${thg}.var}
.if !defined(${var}.${obj:T})
.if defined(${var})
${var}.${obj:T}=${${var}}
.endif
.endif
.endfor
.endfor
.endfor

#
# Building command lines
#

.for thg in ${_OCAML_OBJECT}
.for obj in ${${${thg}.obj}}
.if !defined(_OCAML_BUILD.${obj:T})
_OCAML_BUILD.${obj:T}=${${${thg}.cmd}}
#
# Flags
#
.for var in ${${thg}.var:M*FLAGS}
.if defined(${var}.${obj:T})&&!empty(${var}.${obj:T})
_OCAML_BUILD.${obj:T}+=${${var}.${obj:T}}
.endif
.endfor
#
# Output name
#
_OCAML_BUILD.${obj:T}+=-o ${.TARGET}
#
# Additional parameters
#
.if !empty(${thg}.var:M*ADD)
.for var in ${${thg}.var:M*ADD}
.if defined(${var}.${obj:T})&&!empty(${var}.${obj:T})
_OCAML_BUILD.${obj:T}+=${${var}.${obj:T}}
.endif
.endfor
.endif

.endif

.if defined(_OCAML_CMXA)&&!empty(_OCAML_CMXA:M${obj})
# We are producing a CMXA file
clib:=${obj:C/.cmxa/.a/}
.if !target(${clib})
# The C library file will be produced by ocamlmklib
${clib}: ${obj}
	${NOP}
.endif
.undef clib
.endif
.if (empty(_OCAML_CMO)||empty(_OCAML_CMO:M${obj}))&&(empty(_OCAML_CMX)||empty(_OCAML_CMX:M${obj}))
# We are not building a CMO nor a CMX file
${obj}:
	${_OCAML_BUILD.${obj:T}} ${.ALLSRC:N*.cmi}
.else
# We are building a CMO or a CMX file
if:=${obj:C/.cm[xo]/.cmi/}
.if !(empty(_OCAML_CMI)||empty(_OCAML_CMI:M${if}))
${obj}: ${if}
${obj}:
.else
.if !target(${if})
# The CMI file will be produced from the object
${if}: ${obj}
	${NOP}
${obj}:
.else
# The CMI file comes from a MLI that is previously built
${obj}: ${if}
${obj}:
.endif
.endif
	${_OCAML_BUILD.${obj:T}} ${.ALLSRC:M*.ml}
.endif
.undef if


.endfor
.endfor

### End of file `ocaml.build.mk'
