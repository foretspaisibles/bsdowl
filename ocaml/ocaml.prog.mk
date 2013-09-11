### ocaml.prog.mk -- Préparation de programmes avec Objective Caml

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

# PROG =	basicrun
# SRCS+=	main.ml
# SRCS+=	basic_types.ml
# SRCS+=	basic_parser.mly basic_lexer.mll
# SRCS+=	basic_process.ml basic_run.ml
# LIBS =	unix
# TARGET =	native_code

# If you have many small programs that share a common set of modules,
# and do not want ship these modules as a library, you can use the
# following:
#
# PROG =	client server
# SRCS =        protocol.ml
# LIBS =	unix
#
# If files client.ml and server.ml do exist, they are appended to the
# automatic value of SRCS.client and SRCS.server, so that after the
# treatment you end up with the following values:
#
# SRCS.client = ${SRCS} client.ml
# SRCS.server = ${SRCS} server.ml
#
# This scheme is useful when writing on programs testing a
# functionality or regression tests, so that you can keep all of them
# in a single directory.

### DESCRIPTION


### MAGIC STUFF

.include "bps.init.mk"
.include "ocaml.init.mk"

.if defined(PROG)&&!empty(PROG)
PROGRAM?= ${PROG}
.endif

.if !defined(PROGRAM)||empty(PROGRAM)
.error The ocaml.prog.mk module expects you to set the PROGRAM or the PROG variable to a sensible value.
.endif

## DU MODE SINGLETON AU MODE ENSEMBLE

.for item in ${PROGRAM}
_OCAML_SRCS+=SRCS.${item:T}
.if !defined(SRCS.${item:T})
SRCS.${item:T} = ${SRCS}
.if exists(${item}.ml)
SRCS.${item:T}+= ${item}.ml
.endif
.endif
.if defined(_OCAML_COMPILE_NATIVE)
SRCS.${item:T}.cn?=${SRCS.${item:T}}
_OCAML_CN+=${item:T}.cn
.endif
.if defined(_OCAML_COMPILE_BYTE)
SRCS.${item:T}.cb?=${SRCS.${item:T}}
_OCAML_CB+=${item:T}.cb
.endif
.if defined(LIBS)&&!empty(LIBS)
LIBS.${item:T}.cb?=${LIBS:=.cma}
LIBS.${item:T}.cn?=${LIBS:=.cmxa}
.endif
.endfor

.include "ocaml.main.mk"

### CIBLES ADMINISTRATIVES

.for item in ${PROGRAM}
BIN+=${item}
CLEANFILES+=${item}
.if defined(_OCAML_COMPILE_NATIVE)
${item}: ${item}.cn
	${CP} ${item}.cn ${item}
_OCAML_SRCS.${item}.cn=${.ALLSRC}
.if !empty(LIBS.${item}.cn)
${item}.cn: ${LIBS.${item}.cn}
.endif
.if !empty(SRCS.${item}.cn)
${item}.cn: ${SRCS.${item}.cn:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmx}
.endif
.endif
.if defined(_OCAML_COMPILE_BYTE) && !target(${item})
${item}: ${item}.cb
	${CP} ${item}.cb ${item}
_OCAML_SRCS.${item}.cb=${.ALLSRC}
.if !empty(LIBS.${item}.cb)
${item}.cb: ${LIBS.${item}.cb}
.endif
.if !empty(SRCS.${item}.cb)
${item}.cb: ${SRCS.${item}.cb:C/\.ml[ly]/.ml/:M*.ml:.ml=.cmo}
.endif
.endif
.endfor

.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `ocaml.prog.mk'
