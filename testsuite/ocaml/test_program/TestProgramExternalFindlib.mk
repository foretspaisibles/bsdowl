### TestProgramExternalFindlib.mk -- Test findlib

# Author: Michael Grünewald
# Date: Thu Oct  3 22:42:23 CEST 2013

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

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
