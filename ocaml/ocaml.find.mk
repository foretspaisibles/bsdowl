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
# .include "ocaml.compile.mk"
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
#
#
#  WITH_THREADS (no)
#   Build with threads support
#
#
#  WITH_VMTHREADS (no)
#   Force VM-level scheduling of threads in byte-code programs

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
WITH_PROFILE?=no

.if ${USE_OCAMLFIND} == yes
OCAMLDOC?= ocamlfind ocamldoc
OCAMLMKTOP?= ocamlfind ocamlmktop -linkpkg
.if ${WITH_PROFILE} == yes
# Profiling case
OCAMLCB?= ocamlfind ocamlcp -c
OCAMLCN?= ocamlfind ocamloptp -c
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
OCAMLCI?= ocamlfind ocamloptp -c
.else
OCAMLCI?= ocamlfind ocamlcp -c
.endif
OCAMLLB?= ocamlfind ocamlcp -linkpkg
OCAMLLN?= ocamlfind ocamloptp -linkpkg
.else
# Not profiling case
OCAMLCB?= ocamlfind ocamlc -c
OCAMLCN?= ocamlfind ocamlopt -c
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
OCAMLCI?= ocamlfind ocamlopt -c
.else
OCAMLCI?= ocamlfind ocamlc -c
.endif
OCAMLLB?= ocamlfind ocamlc -linkpkg
OCAMLLN?= ocamlfind ocamlopt -linkpkg
.endif
.endif


.if defined(WITH_THREADS)&&(${WITH_THREADS} == yes)
.if empty(PKGS:Mthreads)
PKGS+= threads
.endif
.endif


.for pseudo in OCAMLCB OCAMLCN OCAMLCI OCAMLLB OCAMLLN OCAMLDOC OCAMLMKTOP
.if defined(PKGS)&&!empty(PKGS)
${pseudo}+= -package "${PKGS}"
.endif
.if defined(WITH_THREADS)&&(${WITH_THREADS} == yes)
.if defined(WITH_VMTHREADS)&&(${WITH_VMTHREADS} == yes)
${pseudo}+= -threads
.else
${pseudo}+= -vmthreads
.endif
.endif
.if defined(PREDICATES)&&!empty(PREDICATES)
${pseudo}+= -predicates "${PREDICATES}"
.endif
.endfor

.endif #!target(__<ocaml.find.mk>__)

### End of file `ocaml.find.mk'
