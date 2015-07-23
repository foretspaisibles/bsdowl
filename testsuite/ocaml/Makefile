### Makefile -- Test Suite for OCaml

# Author: Michael Grünewald
# Date: Fri Oct 17 13:50:39 CEST 2014

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


SUBDIR=		test_program
SUBDIR+=	test_library
SUBDIR+=	test_complex

.if "${WITH_TESTSUITE_FINDLIB}" == "yes"
.if defined(OCAMLVERSION)&&!empty(OCAMLVERSION)
.if ${OCAMLVERSION} > 000400000000
SUBDIR+=	test_toplevel
.endif
.endif
.endif

.include "generic.subdir.mk"

### End of file `Makefile'
