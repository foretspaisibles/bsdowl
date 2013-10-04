### ocaml.find.mk -- Interface with ocamlfind

# Author: Michael Grünewald
# Date: Sat Jul  7 20:14:16 CEST 2007

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2006-2009, 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# USE_OCAMLFIND = yes
#
# PKGS+= unix
# PKGS+= nums
#
# PREDICATES+= mt
#
# .include "ocaml.target.mk"
# .include "ocaml.find.mk"
# .include "ocaml.tools.mk"


### DESCRIPTION

# We provide virtual tools based on the ocamlfind utility upon
# explicit request of the user (USE_OCAMLFIND) or when idiosyncratic
# variables are defined (PKGS, PREDICATES).
#
# This module is intended to be included by other modules rather than
# to serve as is to the end user.

# Variables:
#
#  PKGS
#   List of packages to use
#
#
#  PREDICATES
#   List of predicates to use
#
#
#  USE_OCAMLFIND
#   Flag governing the activation of ocamlfind
#
#
#  WITH_PROFILE
#   Knob controlling build of files with profiling information
#
#   Setting WITH_PROFILE to yes will enforce the use of the profiling
#   front-ends to OCaml compilers.


### IMPLEMENTATION

.if !target(__<ocaml.find.mk>__)
__<ocaml.find.mk>__:

#
# Detect idiosyncratic variables
#

.if defined(PKGS)&&!empty(PKGS)
USE_OCAMLFIND?=yes
.endif

.if defined(PREDICATES)&&!empty(PREDICATES)
USE_OCAMLFIND?=yes
.endif


#
# Conditionally define virtual tools
#

USE_OCAMLFIND?=no

.if ${USE_OCAMLFIND} == yes
OCAMLDOC?= ocamlfind ocamldoc
OCAMLMKTOP?= ocamlfind ocamlmktop
.if !defined(WITH_PROFILE)||(${WITH_PROFILE != yes)
# Not profiling case
MLCB?= ocamlfind ocamlc -c
MLCN?= ocamlfind ocamlopt -c
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
MLCI?= ocamlfind ocamlopt -c
.else
MLCI?= ocamlfind ocamlc -c
.endif
MLLB?= ocamlfind ocamlc -linkpkg
MLLN?= ocamlfind ocamlopt -linkpkg
.endif
.else
# Profiling case
MLCB?= ocamlfind ocamlcp -c
MLCN?= ocamlfind ocamloptp -c
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
MLCI?= ocamlfind ocamloptp -c
.else
MLCI?= ocamlfind ocamlcp -c
.endif
MLLB?= ocamlfind ocamlcp -linkpkg
MLLN?= ocamlfind ocamloptp -linkpkg
.endif
.endif

.for pseudo in MLCB MLCN MLCI MLLB MLLN OCAMLDOC OCAMLMKTOP
.if defined(PKGS)&&!empty(PKGS)
${pseudo}+= -package "${PKGS}"
.endif
.if defined(PREDICATES)&&!empty(PREDICATES)
${pseudo}+= -predicates "${PREDICATES}"
.endif
.endfor

.endif #!target(__<ocaml.find.mk>__)

### End of file `ocaml.find.mk'
