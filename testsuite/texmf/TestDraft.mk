### TestDraft.mk -- Test draft support

# Author: Michael Grünewald
# Date: Thu Nov 27 22:24:57 CET 2014

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

TEST_DESCRIPTION=	LaTeX document with installed with draft stamp
TEST_SOURCEDIR=		example/texmf/draft
TEST_MATRIX=		TEXDRAFTSTAMP

TEST_TEXDRAFTSTAMP=	DRAFT

.if "${WITH_TESTSUITE_TEXMF}" == "yes"
TEST_SEQUENCE=		preparatives all install
.else
TEST_SEQUENCE=		IGNORE
.endif

test:
	test -f ${DESTDIR}${DOCDIR}/galley_${TEXDRAFTSTAMP}.pdf

### End of file `TestDraft.mk'
