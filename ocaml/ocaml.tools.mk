### ocaml.tools.mk -- Define virtual tools for OCaml

# Author: Michael Grünewald
# Date: Sat Jul  7 20:50:52 CEST 2007

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2007-2009, 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# .include "ocaml.target.mk"
# .include "ocaml.tools.mk"


### DESCRIPTION

# We define virtual tools to access the OCaml tools suite.  Some
# modules adjust these variables (as ocaml.find.mk) or define more (as
# ocaml.depend.mk).

# Variables:
#
#  MLCB (ocamlc)
#   Bytecode compiler
#
#
#  MLCN (ocamlopt)
#   Native compiler
#
#
#  MLCI (ocamlc or ocamlopt)
#   Interface compiler
#
#   We use ocamlc to compile interface files or ocamlopt in the case
#   where only native code executables are prepared.  The produced
#   compiled interfaces should be identical.
#
#
#  MLAB (ocamlc -a)
#   Bytecode libraries packager
#
#
#  MLAN (ocamlopt -a)
#   Native libraries packager
#
#
#  MLLB (ocamlc)
#   Bytecode program linker
#
#
#  MLLN (ocamlopt)
#   Native program linker
#
#
#  MLPB (ocamlc -pack)
#   Bytecode packed module packager
#
#
#  MLPN (ocamlopt -pack)
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



### IMPLEMENTATION

.if !target(__<ocaml.tools.mk>__)
__<ocaml.tools.mk>__:

_OCAML_TOOLS+= MLCI MLCB MLCN MLAB MLAN MLLB MLLN MLPB MLPN

WITH_PROFILE?= no

.if ${WITH_PROFILE} == yes
# Profiling case
MLCB?= ocamlcp -c
MLCN?= ocamloptp -c
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
MLCI?= ocamloptp -c
.else
MLCI?= ocamlcp -c
.endif
MLAB?= ocamlcp -a
MLAN?= ocamloptp -a
MLLB?= ocamlcp
MLLN?= ocamloptp
MLPB?= ocamlcp -pack
MLPN?= ocamloptp -pack
.else
# Not profiling case
MLCB?= ocamlc -c
MLCN?= ocamlopt -c
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
MLCI?= ocamlopt -c
.else
MLCI?= ocamlc -c
.endif
MLAB?= ocamlc -a
MLAN?= ocamlopt -a
MLLB?= ocamlc
MLLN?= ocamlopt
MLPB?= ocamlc -pack
MLPN?= ocamlopt -pack
.endif

.endif#!target(__<ocaml.tools.mk>__)

### End of file `ocaml.tools.mk'
