### ocaml.lex.mk -- Analyseurs syntaxiques produits par ocamllex

# Author: Michael Grünewald
# Date: Mer  1 aoû 2007 11:38:01 CEST
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

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
