### TestProgramAutoconf.mk -- The obnoxious hello world program

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TEST_DESCRIPTION=	Simple C program configured with GNU autoconf
TEST_SOURCEDIR=		example/langc/hello_autoconf
TEST_SEQUENCE=		preparatives all install

CONFIGURE_ARGS=		${TEST_CONFIGURE_ARGS}

test:
	test -f ${.CURDIR}/configure
	test -f ${.CURDIR}/config.status
	test -x ${DESTDIR}${BINDIR}/hello_world
	test -f ${DESTDIR}${MANDIR}/man1/hello_world.1.gz

### End of file `TestProgramAutoconf.mk'
