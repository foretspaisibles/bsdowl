### TestProgram.mk -- The obnoxious hello world program

# Author: Michael Grünewald
# Date: Fri Nov  7 10:16:01 CET 2014

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

TEST_DESCRIPTION=	Simple C program
TEST_SOURCEDIR=		example/langc/hello_world
TEST_SEQUENCE=		preparatives all install

TEST_MATRIX=		PROFILE DEBUG
TEST_PROFILE=		yes no
TEST_DEBUG=		yes no

.if !empty(PROFILE:Myes)
USES+=			profile
.endif

.if !empty(DEBUG:Myes)
USES+=			debug
.endif

test:
	test -x ${DESTDIR}${BINDIR}/hello_world
	test -f ${DESTDIR}${MANDIR}/man1/hello_world.1.gz

### End of file `TestProgram.mk'
