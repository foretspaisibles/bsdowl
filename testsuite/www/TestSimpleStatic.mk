### TestSimpleStatic.mk -- Generate a simple static HTML document

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

TEST_DESCRIPTION=	Simple static HTML document
TEST_SOURCEDIR=		example/www

.if "${WITH_TESTSUITE_SGMLNORM}" == "yes"
TEST_SEQUENCE=		preparatives all install
.else
TEST_SEQUENCE=		IGNORE
.endif

TEST_MATRIX=		WWWROOTDIR
TEST_WWWROOTDIR=	/var/www

test:
	test -f ${DESTDIR}/var/www/index.html

### End of file `TestSimpleStatic.mk'
