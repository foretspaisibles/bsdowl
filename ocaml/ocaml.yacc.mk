### ocaml.yacc.mk -- Analyseur syntaxiques

# Author: Michael Grünewald
# Date: Sam  7 jul 2007 21:16:36 CEST

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
	${OCAMLYACC} -b ${.TARGET:S/.mli$//:S/.ml$//} ${.ALLSRC}

${parser:.mly=.cmo}: ${parser:.mly=.cmi}

.endfor
.endif

.endif # !target(__<ocaml.yacc.mk>__)

### End of file `ocaml.yacc.mk'
