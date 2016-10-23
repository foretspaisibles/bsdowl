### TestProgram.mk -- Test a Python Program

# Author: Michael Grünewald
# Date: Fri Nov 21 15:29:36 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TEST_DESCRIPTION=	Simple Python program
TEST_SOURCEDIR=		example/script/python/showconfig
TEST_SEQUENCE=		preparatives all install

test:
	test -x ${DESTDIR}${BINDIR}/showconfig
	test -f ${DESTDIR}${MANDIR}/man1/showconfig.1.gz

### End of file `TestProgram.mk'
