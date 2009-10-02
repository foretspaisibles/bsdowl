### ocaml.object.mk -- Calcul des variables OBJECT

# Author: Michaël Le Barbier Grünewald
# Date: Mer  1 aoû 2007 11:37:14 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) Michaël Le Barbier Grünewald - 2006-2009
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


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
