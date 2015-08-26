### TestDraft.mk -- Test draft support

# Author: Michael Grünewald
# Date: Thu Nov 27 22:24:57 CET 2014

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

TEST_DESCRIPTION=	LaTeX document with installed with draft stamp
TEST_SOURCEDIR=		example/texmf/draft

.if "${WITH_TESTSUITE_TEXMF}" == "yes"
TEST_SEQUENCE=		preparatives all install
.else
TEST_SEQUENCE=		IGNORE
.endif

TEST_DRAFTSTAMP_CMD=	git log -1 --pretty=tformat:'%ai %h' | tr ' ' '_'
TEST_DRAFTSTAMP!=	(cd ${.CURDIR} && ${TEST_DRAFTSTAMP_CMD})

test:
	test -f ${DESTDIR}${DOCDIR}/simple_${TEST_DRAFTSTAMP}.pdf

### End of file `TestDraft.mk'
