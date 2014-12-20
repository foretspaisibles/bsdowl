### TestProgramExternalFindlib.mk -- Test findlib

# Author: Michael Grünewald
# Date: Thu Oct  3 22:42:23 CEST 2013

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

TEST_DESCRIPTION=	Simple OCaml program linking a findlib library
TEST_SOURCEDIR=		example/ocaml/rolling_stone

.if "${WITH_TESTSUITE_FINDLIB}" == "yes"
TEST_SEQUENCE=		preparatives all install
.else
TEST_SEQUENCE=		IGNORE
.endif

test:
	test -x ${DESTDIR}${BINDIR}/rolling_stone

### End of file `TestProgramExternalFindlib.mk'
