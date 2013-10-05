### ocaml.depend.mk

# Author: Michael Grünewald
# Date: Sam  7 jul 2007 20:40:59 CEST
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2006-2013, 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# Define a rule to rebuild the .depend target. It uses the contents of
# _OCAML_SRCS to populate the parents of `.depend`.

# .depend: module1.ml
# .depend: module1.mli
# .depend: module2.mly
# .depend: module3.mll
# .include "ocaml.depend.mk"


### DESCRIPTION

# Targets:
# do-depend
# do-clean-depend

# Variables:

.if !target(__<ocaml.depend.mk>__)
__<ocaml.depend.mk>__:

.for thg in ${_OCAML_SRCS}
.for item in ${${thg}}
.depend: ${item:C/.ml[ly]/.ml/}
.if exists(${item:.ml=.mli})
.depend: ${item:.ml=.mli}
.endif
.if !empty(${thg}:M*mly)
.for item in ${${thg}:M*.mly}
.if !exists(${item:.mly=.mli})
.depend: ${item:.mly=.mli}
.endif
.endfor
.endif
.endfor
# This logic adds implementation files associated to lexers when they
# are defined.  Does it belongs `ocaml.lex.mk`?
.for item in ${${thg}:M*.mll}
.if exists(${item:.mll=.mli})
.depend: ${item:.mll=.mli}
.endif
.endfor
# This logic adds implementation files associated to parsers. Does it
# belongs `ocaml.yacc.mk`?
.for item in ${${thg}:M*.mly}
.depend: ${item:.mly=.mli}
.endfor
.endfor

.depend:
.if !defined(_OCAML_COMPILE_NATIVE_ONLY)
	ocamldep ${MLDEPFLAGS} ${.ALLSRC} > ${.TARGET}
.else
	ocamldep -native ${MLDEPFLAGS} ${.ALLSRC} > ${.TARGET}
.endif

REALCLEANFILES+= .depend

.if target(do-depend)
do-depend: .depend
.endif

.endif # !target(__<ocaml.depend.mk>__)

### End of file `ocaml.depend.mk'
