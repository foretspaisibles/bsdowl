### TestPerlProgram.mk -- Prepare a simple Perl module

# Author: Michael Grünewald
# Date: Fri Nov 21 15:21:04 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2015 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


TEST_DESCRIPTION=	Simple perl program
TEST_SOURCEDIR=		example/script/perl/showconfig
TEST_SEQUENCE=		preparatives all install

test:
	test -x ${DESTDIR}${BINDIR}/showconfig
	test -f ${DESTDIR}${MANDIR}/man1/showconfig.1.gz
	${DESTDIR}${BINDIR}/showconfig | grep -q ${libexecdir}/showconfig

### End of file `TestPerlProgram.mk'
