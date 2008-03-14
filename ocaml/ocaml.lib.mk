### ocaml.lib.mk -- Préparation de programmes avec Objective Caml

# Author: Michaël Grünewald
# Date: Mar  5 avr 2005 10:31:04 GMT
# Lang: fr_FR.ISO8859-15

# $Id$

# Copyright (c) 2008, Michaël Grünewald
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

.include "make.init.mk"
.include "ocaml.init.mk"

.if !defined(LIBRARY)||empty(LIBRARY)
.error The ocaml.lib.mk expects you to set the LIBRARY variable to a sensible value.
.endif

_OCAML_LIB:=${LIBRARY}

.for lib in ${_OCAML_LIB}
SRCS.${lib:T}?=${SRCS}
.if !empty(TARGET:Mnative_code)
_OCAML_SRCS+=SRCS.${lib}.cmxa
SRCS.${lib:T}.cmxa?=${SRCS.${lib:T}}
_OCAML_CMXA+=${lib:T}.cmxa
_OCAML_A+=${lib:T}.a
.endif
.if !empty(TARGET:Mbyte_code)
_OCAML_SRCS+=SRCS.${lib}.cma
SRCS.${lib:T}.cma?=${SRCS.${lib:T}}
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
_OCAML_SRCS.${lib}.cma=${.ALLSRC}
${lib}.cma: ${SRCS.${lib}.cma:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmo}
.endif
.if !empty(SRCS.${lib}:C/\.ml[ly]/.ml/:M*.ml)
LIB+= ${SRCS.${lib}:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmi}
.endif
.endfor

LIBDIR=${PREFIX}/lib/ocaml${APPLICATIONDIR}

.include "make.clean.mk"
.include "make.files.mk"
.include "make.usertarget.mk"

### End of file `ocaml.lib.mk'
