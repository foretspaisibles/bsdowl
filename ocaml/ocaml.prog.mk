### ocaml.prog.mk -- Préparation de programmes avec Objective Caml

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

# PROGRAM =	basicrun
# SRCS+=	main.ml
# SRCS+=	basic_types.ml
# SRCS+=	basic_parser.mly basic_lexer.mll
# SRCS+=	basic_process.ml basic_run.ml
# LIBS =	unix
# TARGET =	native_code

# PROGRAM =	client server
# SRCS.client =	client.ml protocol.ml
# SRCS.server =	server.ml protocol.ml
# LIBS =	unix

### DESCRIPTION


### MAGIC STUFF

.include "make.init.mk"
.include "ocaml.init.mk"

## DU MODE SINGLETON AU MODE ENSEMBLE

.if !defined(PROGRAM)||empty(PROGRAM)
.error The ocaml.prog.mk module expects you to set the PROGRAM variable to a sensible value.
.endif

.for item in ${PROGRAM}
_OCAML_SRCS+=SRCS.${item:T}
SRCS.${item:T}?=${SRCS}
.if !empty(TARGET:Mnative_code)
SRCS.${item:T}.cn?=${SRCS.${item:T}}
_OCAML_CN+=${item:T}.cn
.endif
.if !empty(TARGET:Mbyte_code)
SRCS.${item:T}.cb?=${SRCS.${item:T}}
_OCAML_CB+=${item:T}.cb
.endif
.if defined(LIBS)&&!empty(LIBS)
LIBS.${item:T}.cb?=${LIBS:=.cma}
LIBS.${item:T}.cn?=${LIBS:=.cmxa}
.endif
.if defined(LIBS.${item:T}.cb)&&!empty(LIBS.${item:T}.cb)
MLLBADD.${item:T}.cb+=${LIBS.${item:T}.cb}
.endif
.if defined(LIBS.${item:T}.cn)&&!empty(LIBS.${item:T}.cn)
MLLNADD.${item:T}.cn+=${LIBS.${item:T}.cn}
.endif
.endfor

.include "ocaml.main.mk"

### CIBLES ADMINISTRATIVES

.for item in ${PROGRAM}
BIN+=${item}
CLEANFILES+=${item}
.if !empty(TARGET:Mnative_code)
${item}: ${item}.cn
	${CP} ${item}.cn ${item}
_OCAML_SRCS.${item}.cn=${.ALLSRC}
.if !empty(SRCS.${item}.cn)
${item}.cn: ${SRCS.${item}.cn:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmx}
.endif
.endif
.if !empty(TARGET:Mbyte_code) && !target(${item})
${item}: ${item}.cb
	${CP} ${item}.cb ${item}
_OCAML_SRCS.${item}.cb=${.ALLSRC}
.if !empty(SRCS.${item}.cb)
${item}.cb: ${SRCS.${item}.cb:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmo}
.endif
.endif
.endfor

.include "make.clean.mk"
.include "make.files.mk"
.include "make.usertarget.mk"

### End of file `ocaml.prog.mk'
