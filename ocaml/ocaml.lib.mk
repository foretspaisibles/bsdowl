### ocaml.lib.mk -- Préparation de programmes avec Objective Caml

# Author: Michaël Le Barbier Grünewald
# Date: Mar  5 avr 2005 10:31:04 GMT
# Lang: fr_FR.ISO8859-15

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

### DESCRIPTION

### MAGIC STUFF

.include "bps.init.mk"
.include "ocaml.init.mk"

# Il ne faut pas utiliser LIB comme nom court pour LIBRARY puisque cet
# identifiant est le nom d'un groupe d'installation de fichiers.
#
# .if defined(LIB)&&!empty(LIB)
# LIBRARY?= ${LIB}
# .endif

.if !defined(LIBRARY)||empty(LIBRARY)
.error The ocaml.lib.mk expects you to set the LIBRARY variable to a sensible value.
.endif

_OCAML_SRCS?=
_OCAML_CMA?=
_OCAML_CMXA?=
_OCAML_A?=

_OCAML_LIB:=${LIBRARY}

.for lib in ${_OCAML_LIB}
SRCS.${lib:T}?=${SRCS}
.if !empty(TARGET:Mnative_code)
SRCS.${lib:T}.cmxa?=${SRCS.${lib:T}}
_OCAML_SRCS+=SRCS.${lib}.cmxa
_OCAML_CMXA+=${lib:T}.cmxa
_OCAML_A+=${lib:T}.a
.endif
.if !empty(TARGET:Mbyte_code)
SRCS.${lib:T}.cma?=${SRCS.${lib:T}}
_OCAML_SRCS+=SRCS.${lib}.cma
_OCAML_CMA+=${lib:T}.cma
.endif
.endfor

## MORE MAGIC

.include "ocaml.main.mk"

### CIBLES ADMINISTRATIVES

.for lib in ${_OCAML_LIB}
.if !empty(TARGET:Mnative_code)
LIB+= ${lib}.cmxa ${lib}.a
_OCAML_SRCS.${lib}.cmxa=${.ALLSRC}
${lib}.cmxa: ${SRCS.${lib}.cmxa:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmx}
.endif
.if !empty(TARGET:Mbyte_code)
LIB+= ${lib}.cma
_OCAML_SRCS.${lib:T}.cma=${.ALLSRC}
${lib}.cma: ${SRCS.${lib:T}.cma:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmo}
.endif
.if !empty(SRCS.${lib:T}:C/\.ml[ly]/.ml/:M*.ml)
LIB+= ${SRCS.${lib:T}:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmi}
.endif
.endfor

LIBDIR?=${PREFIX}/lib/ocaml${APPLICATIONDIR}

.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `ocaml.lib.mk'
