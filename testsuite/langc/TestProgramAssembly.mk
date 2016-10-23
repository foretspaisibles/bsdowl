### TestProgramAssembly.mk -- The obnoxious hello world program

# Author: Michael Grünewald
# Date: Thu Nov 20 11:56:52 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TEST_DESCRIPTION=	Simple C program linked with an assembly module
TEST_SOURCEDIR=		example/langc/hello_assembly
TEST_SEQUENCE=		preparatives all install

test:
	test -x ${DESTDIR}${BINDIR}/hello_world
	test -f ${DESTDIR}${MANDIR}/man1/hello_world.1.gz

### End of file `TestProgramAssembly.mk'
