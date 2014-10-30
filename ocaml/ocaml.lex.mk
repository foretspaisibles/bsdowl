### ocaml.lex.mk -- Support for the OCaml lexer generator

# Author: Michael Grünewald
# Date: Wed Aug  1 11:38:01 CEST 2007

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2014 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# .include "ocaml.lex.mk"


### DESCRIPTION

# We analyse each list of sources appearing in _OCAML_SRCS and when we
# spot an OCaml lexer input file, require it to be processed by
# ocamllex.
#
# This module is intended to be included by other modules rather than
# to serve as is to the end user.


# Variables:
#
#
#  OCAMLLEX
#   Command used to run the lexer generator
#
#
#  _OCAML_MLL
#   Detected lexers are added to this list
#
#
#  _OMCAML_MLI
#   Interfaces associated to detected lexers are added to this list

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

${lexer:.mll=.ml}: ${lexer}
	${OCAMLLEX} -o ${.TARGET} ${.ALLSRC}

.endfor
.endif

.endif # !target(__<ocaml.lex.mk>__)

### End of file `ocaml.lex.mk'
