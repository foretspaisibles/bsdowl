### ocaml.object.mk -- Determines which objects are to build

# Author: Michael Grünewald
# Date: Wed Aug  1 11:37:14 CEST 2007

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

# _OCAML_ML+= module.ml
# _OCAML_ML+= extra.ml
# _OCAML_MLI+= module.mli
# .include "ocaml.object.mk"

### DESCRIPTION

# We scan _OCAML_ML and _OCAML_MLI variables, determine which
# objects are to be built and update _OCAML_CMI, _OCAML_CMO, OCAML_CMX,
# _OCAML_O and CLEANFILES accordingly.
#
# For each inferred object file, the variable _OCAML_SRCS.${object:T}
# is appropriately filled.
#
# This module is intended to be included by other modules rather than
# to serve as is to the end user.

# Variables:
#
#
#  _OCAML_ML, _OCAML_MLI
#   Lists of files to process
#
#
#  _OCAML_CMI, _OCAML_CMO, OCAML_CMX, _OCAML_O
#   Lists of inferred objects
#
#
#  _OCAML_SRCS.*
#   Lists of sources for inferred objects


.if !target(__<ocaml.object.mk>__)
__<ocaml.object.mk>__:

_OCAML_SRCS?=
_OCAML_MLI?=
_OCAML_ML?=
_OCAML_CMI?=
_OCAML_CMO?=
_OCAML_CMX?=
_OCAML_O?=

.if !empty(_OCAML_MLI)
.for if in ${_OCAML_MLI:.mli=.cmi}
.if empty(_OCAML_CMI:M${if})
_OCAML_CMI+=${if}
.endif
.endfor
.endif


.if !empty(_OCAML_ML)

.if defined(_OCAML_COMPILE_BYTE)
.for unit in ${_OCAML_ML:.ml=.cmo}
.if empty(_OCAML_CMO:M${unit})
_OCAML_CMO+=${unit}
.endif
.endfor
.endif

.if defined(_OCAML_COMPILE_NATIVE)
.for unit in ${_OCAML_ML:.ml=.cmx}
.if empty(_OCAML_CMX:M${unit})
_OCAML_CMX+=${unit}
.endif
.endfor

.for unit in ${_OCAML_ML:.ml=.o}
.if empty(_OCAML_O:M${unit})
_OCAML_O+=${unit}
.endif
.endfor

.endif

.endif

.for obj in ${_OCAML_CMI}
${obj}:${obj:.cmi=.mli}
_OCAML_SRCS.${obj:T}=${obj:.cmi=.mli}
.endfor

.for obj in ${_OCAML_CMO}
${obj}:${obj:.cmo=.ml}
_OCAML_SRCS.${obj:T}=${obj:.cmo=.ml}
.endfor

.for obj in ${_OCAML_CMX}
${obj}:${obj:.cmx=.ml}
_OCAML_SRCS.${obj:T}=${obj:.cmx=.ml}
.endfor

.for var in ${_OCAML_OBJECT}
.if defined(${var})&&!empty(${var})
.for obj in ${${var}} ${${var}:C/.cm[xo]/.cmi/}
.if empty(CLEANFILES:M${obj})
CLEANFILES+= ${obj}
.endif
.endfor
.endif
.endfor

.endif # !target(__<ocaml.object.mk>__)

### End of file `ocaml.object.mk'
