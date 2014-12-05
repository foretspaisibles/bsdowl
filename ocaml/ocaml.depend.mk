### ocaml.depend.mk -- Dependency generator for OCaml modules

# Author: Michael Grünewald
# Date: Sat Jul  7 20:40:59 CEST 2007

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

.if !defined(THISMODULE)
.error ocaml.depend.mk cannot be included directly.
.endif

.if !target(__<ocaml.depend.mk>__)
__<ocaml.depend.mk>__:

.for directory in ${DIRS}
_OCAMLDEP_FILTER_SCRIPT+=	-e "s@${directory}/*@@g"
.endfor

.if ("${.OBJDIR}" != "${.CURDIR}") && empty(DIRS:M${.CURDIR})
_OCAMLDEP_FILTER_SCRIPT+=	-e "s@${.OBJDIR}/*@@g"
OCAMLDEPFLAGS+=			-I ${.OBJDIR}
.endif

_OCAMLDEP_FILTER=	sh -c '${SED} ${_OCAMLDEP_FILTER_SCRIPT}'\
			  -- OCAMLDEP_FILTER

.for thg in ${_OCAML_SRCS}
.for item in ${${thg}}
_OCAML_DEPEND+=		${item:C/.ml[ly]/.ml/}
.if exists(${item:C/.ml[ly]/.ml/:.ml=.mli})
_OCAML_DEPEND+=		${item:C/.ml[ly]/.ml/:.ml=.mli}
.endif
.endfor
.endfor

.if defined(_OCAML_COMPILE_NATIVE_ONLY)
OCAMLDEPFLAGS+=		-native
.endif

.if defined(_OCAML_DEPEND)
.depend: ${_OCAML_DEPEND}
	(cd ${.CURDIR} && ocamldep ${OCAMLDEPFLAGS} ${_OCAML_DEPEND})\
	  | ${_OCAMLDEP_FILTER} \
	  > ${.TARGET}
.else
.depend: .PHONY
	${NOP}
.endif

DISTCLEANFILES+=	.depend

.if target(do-depend)
do-depend: .depend
.endif

.endif # !target(__<ocaml.depend.mk>__)

### End of file `ocaml.depend.mk'
