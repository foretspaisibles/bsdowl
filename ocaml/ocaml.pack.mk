### ocaml.pack.mk -- Préparation de programmes avec Objective Caml

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

### DESCRIPTION

### MAGIC STUFF

.include "bps.init.mk"
.include "ocaml.init.mk"

.if !defined(PACK)||empty(PACK)
.error The ocaml.pack.mk module expects you to set the PACK variable to a sensible value.
.endif

_OCAML_SRCS?=
_OCAML_CMA?=
_OCAML_CMXA?=
_OCAML_A?=

_OCAML_PACK:=${PACK}

.for pack in ${_OCAML_PACK}
SRCS.${pack:T}?=${SRCS}
.if defined(_OCAML_COMPILE_NATIVE)
SRCS.${pack:T}.cmx?=${SRCS.${pack:T}}
SRCS.${pack:T}.cmxa?=${pack}.cmx
_OCAML_SRCS+=SRCS.${pack}.cmx
_OCAML_CMXA+=${pack:T}.cmxa
_OCAML_PKX+=${pack:T}.cmx
_OCAML_A+=${pack:T}.a
.endif
.if defined(_OCAML_COMPILE_BYTE)
SRCS.${pack:T}.cmo?=${SRCS.${pack:T}}
SRCS.${pack:T}.cma?=${pack}.cmo
_OCAML_SRCS+=SRCS.${pack}.cmo
_OCAML_CMA+=${pack:T}.cma
_OCAML_PKO+=${pack:T}.cmo
.endif
.endfor

## MORE MAGIC

.include "ocaml.main.mk"

### CIBLES ADMINISTRATIVES

.for pack in ${_OCAML_PACK}
.if defined(_OCAML_COMPILE_NATIVE)
LIB+= ${pack}.cmxa ${pack}.a
_OCAML_SRCS.${pack}.cmx=${.ALLSRC}
_OCAML_SRCS.${pack}.cmxa=${.ALLSRC}
${pack}.cmx: ${SRCS.${pack:T}.cmx:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmx}
${pack}.cmxa: ${pack}.cmx
.endif
.if defined(_OCAML_COMPILE_BYTE)
LIB+= ${pack}.cma
_OCAML_SRCS.${pack}.cmo=${.ALLSRC}
_OCAML_SRCS.${pack}.cma=${.ALLSRC}
${pack}.cmo: ${SRCS.${pack:T}.cmo:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmo}
${pack}.cma: ${pack}.cmo
.endif
LIB+= ${pack}.cmi
.endfor

LIBDIR=${PREFIX}/lib/ocaml${APPLICATIONDIR}

.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `ocaml.pack.mk'
