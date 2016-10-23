### ocaml.yacc.mk -- Support for the OCaml parser generator

# Author: Michael Grünewald
# Date: Sat Jul  7 21:16:36 CEST 2007

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


### SYNOPSIS

# _OCAML_MLY+= parser1.mly
# .include "ocaml.yacc.mk"


### DESCRIPTION


# We analyse each list of sources appearing in _OCAML_SRCS and when we
# spot an OCaml parser input file, require it to be processed by
# ocamllex.
#
# This module is intended to be included by other modules rather than
# to serve as is to the end user.

.if !defined(THISMODULE)
.error ocaml.yacc.mk cannot be included directly.
.endif

.if !target(__<ocaml.yacc.mk>__)
__<ocaml.yacc.mk>__:

OCAMLYACC?= ocamlyacc
_OCAML_MLY?=

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
.if !defined(_OCAML_ML)||empty(_OCAML_ML:M${mod})
_OCAML_ML+= ${mod}
.endif
.endfor
.for if in ${_OCAML_MLY:.mly=.mli}
.if !defined(_OCAML_MLI)||empty(_OCAML_MLI:M${if})
_OCAML_MLI+= ${if}
.endif
.endfor
.endif


.if defined(_OCAML_MLY)&&!empty(_OCAML_MLY)
.for parser in ${_OCAML_MLY}

${parser:.mly=.ml} ${parser:.mly=.mli}: ${parser}
	${OCAMLYACC} -b ${.TARGET:S/.mli$//:S/.ml$//} ${.ALLSRC}

${parser:.mly=.cmo}: ${parser:.mly=.cmi}
${parser:.mly=.cmx}: ${parser:.mly=.cmi}

.endfor
.endif

.endif # !target(__<ocaml.yacc.mk>__)

### End of file `ocaml.yacc.mk'
