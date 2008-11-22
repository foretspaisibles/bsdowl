### ocaml.pack.mk -- Préparation de programmes avec Objective Caml

# Author: Michaël Grünewald
# Date: Mar  5 avr 2005 10:31:04 GMT
# Lang: fr_FR.ISO8859-15

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
.if !empty(TARGET:Mnative_code)
SRCS.${pack:T}.cmx?=${SRCS.${pack:T}}
SRCS.${pack:T}.cmxa?=${pack}.cmx
_OCAML_SRCS+=SRCS.${pack}.cmx
_OCAML_CMXA+=${pack:T}.cmxa
_OCAML_PKX+=${pack:T}.cmx
_OCAML_A+=${pack:T}.a
.endif
.if !empty(TARGET:Mbyte_code)
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
.if !empty(TARGET:Mnative_code)
LIB+= ${pack}.cmxa ${pack}.a
_OCAML_SRCS.${pack}.cmx=${.ALLSRC}
_OCAML_SRCS.${pack}.cmxa=${.ALLSRC}
${pack}.cmx: ${SRCS.${pack:T}.cmx:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmx}
${pack}.cmxa: ${pack}.cmx
.endif
.if !empty(TARGET:Mbyte_code)
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
