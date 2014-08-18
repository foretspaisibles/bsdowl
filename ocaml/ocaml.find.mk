### ocaml.find.mk -- Interface with ocamlfind

# Author: Michael Grünewald
# Date: Sat Jul  7 20:14:16 CEST 2007

# BSD Owl Scripts (https://bitbucket.org/michipili/bsdowl)
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
OCAMLDOC?= ${OCAMLFIND} ocamldoc
OCAMLMKTOP?= ${OCAMLFIND} ocamlmktop -linkpkg
.if ${WITH_PROFILE} == yes
# Profiling case
OCAMLCB?= ${OCAMLFIND} ocamlcp -c
OCAMLCN?= ${OCAMLFIND} ocamloptp -c
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
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
OCAMLCI?= ${OCAMLFIND} ocamlopt -c
.else
OCAMLCI?= ${OCAMLFIND} ocamlc -c
.endif
OCAMLLB?= ${OCAMLFIND} ocamlc -linkpkg
OCAMLLN?= ${OCAMLFIND} ocamlopt -linkpkg
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
