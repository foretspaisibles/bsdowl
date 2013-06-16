### ocaml.target.mk -- Normalisation de la variable TARGET

# Author: Michael Grünewald
# Date: Mar  5 avr 2005 10:31:04 GMT

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
