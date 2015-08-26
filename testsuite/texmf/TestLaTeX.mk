### TestLaTeX.mk -- Simple document using LaTeX

# Author: Michael Grünewald
# Date: Sun Nov 23 16:20:06 CET 2014

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

TEST_DESCRIPTION=	Simple LaTeX document
TEST_SOURCEDIR=		example/texmf/latex

.if "${WITH_TESTSUITE_TEXMF}" == "yes"
TEST_SEQUENCE=		preparatives all install
.else
TEST_SEQUENCE=		IGNORE
.endif

TEST_MATRIX=		TEXDEVICE
TEST_TEXDEVICE=		dvi pdf ps

test:
	test -f ${DESTDIR}${DOCDIR}/simple.${TEXDEVICE}

### End of file `TestLaTeX.mk'
