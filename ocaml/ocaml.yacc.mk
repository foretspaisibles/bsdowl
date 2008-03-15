### ocaml.yacc.mk -- Analyseur syntaxiques

# Author: Michaël Grünewald
# Date: Sam  7 jul 2007 21:16:36 CEST
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

# _OCAML_MLY+= parser1.mly
# .include "ocaml.yacc.mk"


### DESCRIPTION

# Ajuste le contenu de _OCAML_MLY à partir de _OCAML_SRCS.
#
# Installe les cibles permettant la préparation des analyseurs
# lexicaux.
#
# Ajuste les variables _OCAML_ML _OCAML_MLI et CLEANFILES.

.if !target(__<ocaml.yacc.mk>__)
__<ocaml.yacc.mk>__:

OCAMLYACC?= ocamlyacc

.for src in ${_OCAML_SRCS}
.if defined(${src})
.if !empty(${src}:M*.mly)
.for parser in ${${src}:M*.mly}
.if empty(_OCAML_MLY:M${parser})
_OCAML_MLY+=${parser}
.endif
.endfor
.endif
.endif
.endfor

.if defined(_OCAML_MLY)&&!empty(_OCAML_MLY)
.for file in ${_OCAML_MLY:.mly=.mli} ${_OCAML_MLY:.mly=.ml}
.if empty(CLEANFILES:M${file})
CLEANFILES+= ${file}
.endif
.endfor
.for mod in ${_OCAML_MLY:.mly=.ml}
.if empty(_OCAML_ML:M${mod})
_OCAML_ML+= ${mod}
.endif
.endfor
.for if in ${_OCAML_MLY:.mly=.mli}
.if empty(_OCAML_MLI:M${if})
_OCAML_MLI+= ${if}
.endif
.endfor
.endif


.if defined(_OCAML_MLY)&&!empty(_OCAML_MLY)
.for parser in ${_OCAML_MLY}

${parser:.mly=.ml} ${parser:.mly=.mli}: ${parser}
	${OCAMLYACC} ${parser}

${parser:.mly=.cmo}: ${parser:.mly=.cmi}

.endfor
.endif

.endif # !target(__<ocaml.yacc.mk>__)

### End of file `ocaml.yacc.mk'
