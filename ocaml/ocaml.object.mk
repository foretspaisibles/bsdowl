### ocaml.object.mk -- Calcul des variables OBJECT

# Author: Michaël Grünewald
# Date: Mer  1 aoû 2007 11:37:14 CEST
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

# OCAML_ML+= module.ml extra.ml
# OCAML_MLI+= module.mli
# .include "ocaml.object.mk"

### DESCRIPTION

# Déduit du contenu des variables _OCAML_ML et _OCAML_MLI les fichiers
# objet à ajouter aux variables _OCAML_CM* . 
#
# Positionne pour ces objets les variables _OCAML_SRCS.* .
#
# Ajoute ces objets à la variable CLEANFILES.

.if !target(__<ocaml.object.mk>__)
__<ocaml.object.mk>__:


.if !empty(_OCAML_MLI)
.for if in ${_OCAML_MLI:.mli=.cmi}
.if empty(_OCAML_CMI:M${if})
_OCAML_CMI+=${if}
.endif
.endfor
.endif


.if !empty(_OCAML_ML)

.if !empty(TARGET:Mbyte_code)
.for unit in ${_OCAML_ML:.ml=.cmo}
.if empty(_OCAML_CMO:M${unit}) 
_OCAML_CMO+=${unit}
.endif
.endfor
.endif

.if !empty(TARGET:Mnative_code)
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
