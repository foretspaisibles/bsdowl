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


### IMPLEMENTATION

.if !target(__<ocaml.tools.mk>__)
__<ocaml.tools.mk>__:

_OCAML_TOOLS+= MLCI MLCB MLCN MLAB MLAN MLLB MLLN MLPB MLPN

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

.endif#!target(__<ocaml.tools.mk>__)

### End of file `ocaml.tools.mk'
