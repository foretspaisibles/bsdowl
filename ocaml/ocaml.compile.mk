### ocaml.compile.mk -- Prepare the COMPILE variable

# Author: Michael Grünewald
# Date: Tue Apr  5 12:31:04 CEST 2005

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

#  COMPILE = byte_code|native_code|both|bc|nc|byte|native
# .include "ocaml.compile.mk"


### DESCRIPTION


# This module reads the COMPILE variable describing the kind of code
# that shall be produced and defines several variables that can be
# used as predicates in the sequel.
#
# A predicate is true if, and only if, the corresponding variable is
# defined.
#
# This module is intended to be included by other modules rather than
# to serve as is to the end user. (See ocaml.manual.mk for a
# module producing HTML documentation.)


# Variables:
#
#  COMPILE [byte_code]
#    List of targeted code generators
#
#    If this variable contains one of the words byte_code, byte,
#    or both, then the production of byte objects is required.
#
#    If this variable contains one of the words native_code, native
#    or both, then the production of native objects is required.
#
#
#  _OCAML_COMPILE_BYTE
#    Predicate telling if the production of byte objects is required
#
#
#  _OCAML_COMPILE_NATIVE
#    Predicate telling if the production of native objects is required
#
#
#  _OCAML_COMPILE_NATIVE_ONLY
#    Predicate telling if the production requirement narrows to native objects
#
#
#  _OCAML_COMPILE_BOTH
#    Predicate telling if the production requirement includes both types

.if !target(__<ocaml.compile.mk>__)
__<ocaml.compile.mk>__:

.SUFFIXES: .ml .mli .mll .mly .cmi .cmo .cma .cmx .cmxa .byte .native

.if !defined(COMPILE) || empty(COMPILE)
COMPILE = byte_code
.endif

.if !empty(COMPILE:Mbyte_code)||!empty(COMPILE:Mbyte) || !empty(COMPILE:Mboth)
_OCAML_COMPILE_BYTE= yes
.else
.undef _OCAML_COMPILE_BYTE
.endif

.if !empty(COMPILE:Mnative_code)||!empty(COMPILE:Mnative) || !empty(COMPILE:Mboth)
_OCAML_COMPILE_NATIVE= yes
.else
.undef _OCAML_COMPILE_NATIVE
.endif

.if defined(_OCAML_COMPILE_NATIVE)&&defined(_OCAML_COMPILE_BYTE)
_OCAML_COMPILE_BOTH=yes
.else
.undef _OCAML_COMPILE_BOTH
.endif

.if defined(_OCAML_COMPILE_NATIVE)&&!defined(_OCAML_COMPILE_BYTE)
_OCAML_COMPILE_NATIVE_ONLY=yes
.else
.undef _OCAML_COMPILE_NATIVE_ONLY
.endif

.endif #!target(__<ocaml.compile.mk>__)

### End of file `ocaml.compile.mk'
