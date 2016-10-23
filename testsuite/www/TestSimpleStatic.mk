### TestSimpleStatic.mk -- Generate a simple static HTML document

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

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
