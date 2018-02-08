### ocaml.find.mk -- Interface with ocamlfind

# Author: Michael Grünewald
# Date: Sat Jul  7 20:14:16 CEST 2007

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


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
#  WITH_POSIX_THREADS (no)
#   Build with threads support.
#
#    This flag is automatically set if PKGS mentions the threads.posix package.
#
#
#  WITH_VM_THREADS (no)
#   Force VM-level scheduling of threads in byte-code programs
#
#    This flag is automatically set if PKGS mentions the threads.vm package.


### IMPLEMENTATION

.if !defined(THISMODULE)
.error ocaml.find.mk cannot be included directly.
.endif

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
USE_OPTIMIZED_COMPILER?=no

.if ${USE_OCAMLFIND} == yes
.if !defined(USE_OCAMLFIND_COMMANDS)
.if ${WITH_PROFILE} == no && ${USE_OPTIMIZED_COMPILER} == yes
USE_OCAMLFIND_COMMANDS=yes
OCAMLFIND_OCAMLC=ocamlc.opt
OCAMLFIND_OCAMLOPT=ocamlopt.opt
.endif
.endif

USE_OCAMLFIND_COMMANDS?=no
.if ${USE_OCAMLFIND_COMMANDS} == yes
.if !defined(OCAMLFIND_COMMANDS)
OCAMLFIND_OCAMLC?=ocamlc
OCAMLFIND_OCAMLOPT?=ocamlopt
OCAMLFIND_COMMANDS+=ocamlc=${OCAMLFIND_OCAMLC}
OCAMLFIND_COMMANDS+=ocamlopt=${OCAMLFIND_OCAMLOPT}
OCAMLFIND?=${ENVTOOL} OCAMLFIND_COMMANDS="${OCAMLFIND_COMMANDS}" ocamlfind
.else
.endif
.endif
OCAMLFIND?=ocamlfind
.endif

.if ${USE_OCAMLFIND} == yes
OCAMLWHERE?= ${OCAMLFIND} ocamlc -where
OCAMLDOC?= ${OCAMLFIND} ocamldoc
OCAMLMKTOP?= ${OCAMLFIND} ocamlmktop -linkpkg
.if ${WITH_PROFILE} == yes
# Profiling case
OCAMLCB?= ${OCAMLFIND} ocamlcp -c
OCAMLCN?= ${OCAMLFIND} ocamloptp -c
OCAMLCS?= ${OCAMLFIND} ocamloptp -shared
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
OCAMLCI?= ${OCAMLFIND} ocamloptp -c
.else
OCAMLCI?= ${OCAMLFIND} ocamlcp -c
.endif
OCAMLLB?= ${OCAMLFIND} ocamlcp -linkpkg
OCAMLLN?= ${OCAMLFIND} ocamloptp -linkpkg
.else
# Not profiling case
OCAMLCB?= ${OCAMLFIND} ocamlc -c
OCAMLCN?= ${OCAMLFIND} ocamlopt -c
OCAMLCS?= ${OCAMLFIND} ocamlopt -shared
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
OCAMLCI?= ${OCAMLFIND} ocamlopt -c
.else
OCAMLCI?= ${OCAMLFIND} ocamlc -c
.endif
OCAMLLB?= ${OCAMLFIND} ocamlc -linkpkg
OCAMLLN?= ${OCAMLFIND} ocamlopt -linkpkg
.endif
.endif

.if !empty(PKGS:Mthreads.posix)
WITH_POSIX_THREADS?=yes
.else
WITH_POSIX_THREADS?=no
.endif

.if !empty(PKGS:Mthreads.vm)
WITH_VM_THREADS?=yes
.else
WITH_VM_THREADS?=no
.endif

.if ${WITH_POSIX_THREADS} == yes && empty(PKG:Mthreads.posix)
PKGS+= threads.posix
.endif

.if ${WITH_VM_THREADS} == yes && empty(PKG:Mthreads.vm)
PKGS+= threads.vm
.endif


.for pseudo in OCAMLCB OCAMLCN OCAMLCS OCAMLCI OCAMLLB OCAMLLN\
	  OCAMLDOC OCAMLMKTOP
.if defined(PKGS)&&!empty(PKGS)
${pseudo}+= -package "${PKGS}"
.endif
.if ${WITH_POSIX_THREADS} == yes
${pseudo}+= -thread
.elif ${WITH_VM_THREADS} == yes
${pseudo}+= -vmthread
.endif
.if defined(PREDICATES)&&!empty(PREDICATES)
${pseudo}+= -predicates "${PREDICATES}"
.endif
.endfor

.endif #!target(__<ocaml.find.mk>__)

### End of file `ocaml.find.mk'
