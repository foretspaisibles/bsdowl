### ocaml.tools.mk -- Define virtual tools for OCaml

# Author: Michael Grünewald
# Date: Sat Jul  7 20:50:52 CEST 2007

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

# .include "ocaml.compile.mk"
# .include "ocaml.tools.mk"


### DESCRIPTION

# We define virtual tools to access the OCaml tools suite.  Some
# modules adjust these variables (as ocaml.find.mk) or define more (as
# ocaml.depend.mk).

# Variables:
#
#  OCAMLCB (ocamlc)
#   Bytecode compiler
#
#
#  OCAMLCN (ocamlopt)
#   Native compiler
#
#
#  OCAMLCI (ocamlc or ocamlopt)
#   Interface compiler
#
#   We use ocamlc to compile interface files or ocamlopt in the case
#   where only native code executables are prepared.  The produced
#   compiled interfaces should be identical.
#
#
#  OCAMLAB (ocamlc -a)
#   Bytecode libraries packager
#
#
#  OCAMLAN (ocamlopt -a)
#   Native libraries packager
#
#
#  OCAMLLB (ocamlc)
#   Bytecode program linker
#
#
#  OCAMLLN (ocamlopt)
#   Native program linker
#
#
#  OCAMLPB (ocamlc -pack)
#   Bytecode packed module packager
#
#
#  OCAMLPN (ocamlopt -pack)
#   Native packed module packager
#
#
#  _OCAML_TOOLS
#   The list of defined tools
#
#
#  WITH_PROFILE (no)
#   Knob controlling build of files with profiling information
#
#   Setting WITH_PROFILE to yes will enforce the use of the profiling
#   front-ends to OCaml compilers.
#
#
#  USE_OPTIMIZED_COMPILER
#   Use optimized compilers
#
#   This is not compatible with the WITH_PROFILE knob, which will take
#   precedence.

### IMPLEMENTATION

.if !defined(THISMODULE)
.error ocaml.tools.mk cannot be included directly.
.endif

.if !target(__<ocaml.tools.mk>__)
__<ocaml.tools.mk>__:

_OCAML_TOOLS+= OCAMLCI
_OCAML_TOOLS+= OCAMLCB
_OCAML_TOOLS+= OCAMLCN
_OCAML_TOOLS+= OCAMLAB
_OCAML_TOOLS+= OCAMLAN
_OCAML_TOOLS+= OCAMLLB
_OCAML_TOOLS+= OCAMLLN
_OCAML_TOOLS+= OCAMLPB
_OCAML_TOOLS+= OCAMLPN

WITH_PROFILE?= no
USE_OPTIMIZED_COMPILER?= no

.if ${USE_OPTIMIZED_COMPILER} != no && ${WITH_PROFILE} != no
.warning The USE_OPTIMIZED_COMPILER flag is superseded by WITH_PROFILE.
.endif

.if ${WITH_PROFILE} == yes
# Profiling case
OCAMLCB?= ocamlcp -c
OCAMLCN?= ocamloptp -c
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
OCAMLCI?= ocamloptp -c
.else
OCAMLCI?= ocamlcp -c
.endif
OCAMLAB?= ocamlcp -a
OCAMLAN?= ocamloptp -a
OCAMLLB?= ocamlcp
OCAMLLN?= ocamloptp
OCAMLPB?= ocamlcp -pack
OCAMLPN?= ocamloptp -pack
.elif ${USE_OPTIMIZED_COMPILER} == yes
# Optimized compiler case
OCAMLCB?= ocamlc.opt -c
OCAMLCN?= ocamlopt.opt -c
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
OCAMLCI?= ocamlopt.opt -c
.else
OCAMLCI?= ocamlc.opt -c
.endif
OCAMLAB?= ocamlc.opt -a
OCAMLAN?= ocamlopt.opt -a
OCAMLLB?= ocamlc.opt
OCAMLLN?= ocamlopt.opt
OCAMLPB?= ocamlc.opt -pack
OCAMLPN?= ocamlopt.opt -pack
.else
# Normal case
OCAMLCB?= ocamlc -c
OCAMLCN?= ocamlopt -c
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
OCAMLCI?= ocamlopt -c
.else
OCAMLCI?= ocamlc -c
.endif
OCAMLAB?= ocamlc -a
OCAMLAN?= ocamlopt -a
OCAMLLB?= ocamlc
OCAMLLN?= ocamlopt
OCAMLPB?= ocamlc -pack
OCAMLPN?= ocamlopt -pack
.endif

.endif#!target(__<ocaml.tools.mk>__)

### End of file `ocaml.tools.mk'
