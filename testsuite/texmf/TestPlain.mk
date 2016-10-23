### TestPlain.mk -- Simple document using plain TeX

# Author: Michael Grünewald
# Date: Sun Nov 23 16:10:02 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TEST_DESCRIPTION=	Simple plain TeX document
TEST_SOURCEDIR=		example/texmf/tex

.if "${WITH_TESTSUITE_TEXMF}" == "yes"
TEST_SEQUENCE=		preparatives all install
.else
TEST_SEQUENCE=		IGNORE
.endif

TEST_MATRIX=		TEXDEVICE
TEST_TEXDEVICE=		dvi pdf ps

test:
	test -f ${DESTDIR}${DOCDIR}/simple.${TEXDEVICE}

### End of file `TestPlain.mk'
