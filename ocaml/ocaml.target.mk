### ocaml.target.mk -- Normalisation de la variable TARGET

# Author: Michaël Grünewald
# Date: Mar  5 avr 2005 10:31:04 GMT
# Lang: fr_FR.ISO8859-1

# $Id$

# Copyright (c) 2006, 2007, 2008, Michaël Grünewald
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#    1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#    2. Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#
#    3. The name of the author may not be used to endorse or promote
#    products derived from this software without specific prior written
#    permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.


### SYNOPSIS

#  TARGET = byte_code|native_code|both|bc|nc|byte|native
# .include "ocaml.init.mk"


### DESCRIPTION

# Ce module normalise la valeur de la variable TARGET.  Après
# évaluation de ces directives, TARGET vaut l'une des valeurs
# suivantes:
#
#  byte_code
#  native_code
#  byte_code native_code
#
# On teste la présence de byte_code avec
#
#  .if !empty(TARGET:Mbyte_code)
#
# etc.
# On s'assure que la variable TARGET ait l'une des valeurs `both',
# 'native_code' ou 'byte_code'.


.if !target(__<ocaml.target.mk>__)
__<ocaml.target.mk>__:

.SUFFIXES: .ml .mli .mll .mly .cmi .cmo .cma .cmx .cmxa .cb .cn
# .cb CAML bytecode
# .cn CAML native object


#
# Normalisation de la variable TARGET
#

# Après évaluation de ces directives, TARGET vaut
#
#  byte_code, native_code ou byte_code native_code
#
# On teste la présence de byte_code avec
#
#  .if !empty(TARGET:Mbyte_code)
#
# etc.
# On s'assure que la variable TARGET ait l'une des valeurs `both',
# 'native_code' ou 'byte_code'.

.if !defined(TARGET) || empty(TARGET)
TARGET = byte_code
.else
.if ${TARGET} == cb || ${TARGET} == byte || ${TARGET} == byte_code
TARGET:= byte_code
.elif ${TARGET} == cn  || ${TARGET} == native || ${TARGET} == native_code
TARGET:= native_code
.endif
.if ${TARGET} == both
TARGET:=byte_code native_code
.endif
.endif


# TARGET est définie et n'est pas vide

#.if !empty(TARGET:Nnative_code:Nbyte_code)
#.error TARGET should be a subset of 'byte_code', 'native_code'. I think that TARGET=${TARGET}.
#.endif

# TARGET est une liste non vide d'éléments parmi byte_code native_code.

.endif #!target(__<ocaml.target.mk>__)

### End of file `ocaml.target.mk'
