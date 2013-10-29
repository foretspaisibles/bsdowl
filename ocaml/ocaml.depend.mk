### ocaml.depend.mk -- Dependency generator

# Author: Michael Grünewald
# Date: Sat Jul  7 20:40:59 CEST 2007

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2007-2013, 2013 Michael Grünewald
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

# We use ocamldep(1) to generate file dependencies in .depend.  We
# run ocamldep(1) on the sources listed in the Makefile.
#
# We need to be smart when handling lexers and parsers because in the
# case of parsers, an interface will be supplied by ocamlyacc(1) if
# the user did not write one.
#
# The case where we are only building native code objects also
# deserves special treatments to avoid creating spurious bytecode
# files.
#
# This module is intended to be included by other modules rather than
# to serve as is to the end user.

# Targets:
# .depend
# do-depend
# do-clean-depend

# Variables:


### IMPLEMENTATION

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
	ocamldep ${OCAMLDEPFLAGS} ${.ALLSRC} > ${.TARGET}
.else
	ocamldep -native ${OCAMLDEPFLAGS} ${.ALLSRC} > ${.TARGET}
.endif

REALCLEANFILES+= .depend

.if target(do-depend)
do-depend: .depend
.endif

.endif # !target(__<ocaml.depend.mk>__)

### End of file `ocaml.depend.mk'
