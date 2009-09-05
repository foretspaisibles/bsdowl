### ocaml.lex.mk -- Analyseurs syntaxiques produits par ocamllex

# Author: Michaël Le Barbier Grünewald
# Date: Mer  1 aoû 2007 11:38:01 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

# Copyright (c) 2006, 2007, 2008, 2009 Michaël Le Barbier Grünewald
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


.if !target(__<ocaml.lex.mk>__)
__<ocaml.lex.mk>__:


OCAMLLEX?= ocamllex

.for src in ${_OCAML_SRCS}
.if defined(${src})
.if !empty(${src}:M*.mll)
.for lexer in ${${src}:M*.mll}
.if empty(_OCAML_MLL)||empty(_OCAML_MLL:M${lexer})
_OCAML_MLL+=${lexer}
.endif
.endfor
.endif
.endif
.endfor

.if defined(_OCAML_MLL)&&!empty(_OCAML_MLL)
.for unit in ${_OCAML_MLL:.mll=.ml}
.if empty(CLEANFILES)||empty(CLEANFILES:M${unit})
CLEANFILES+=${unit}
.endif
.if empty(_OCAML_ML)||empty(_OCAML_ML:M${unit})
_OCAML_ML+=${unit}
.endif
.endfor
.endif

.if defined(_OCAML_MLL)&&!empty(_OCAML_MLL)
.for if in ${_OCAML_MLL:.mll=.mli}
.if exists(${if}) && empty(_OCAML_MLI:M${if})
_OCAML_MLI+=${if}
.endif
.endfor
.for lexer in ${_OCAML_MLL}

${lexer:.mll=.cmo}: ${lexer:.mll=.cmi}

${lexer:.mll=.ml}: ${lexer}
	${OCAMLLEX} -o ${.TARGET} ${.ALLSRC}

.endfor
.endif

.endif # !target(__<ocaml.lex.mk>__)

### End of file `ocaml.lex.mk'
