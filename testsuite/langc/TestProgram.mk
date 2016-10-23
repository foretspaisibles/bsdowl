### TestProgram.mk -- The obnoxious hello world program

# Author: Michael Grünewald
# Date: Fri Nov  7 10:16:01 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

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
