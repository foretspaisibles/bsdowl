### TestProgram.mk -- Counting characters and lines in a file

# Author: Michael Grünewald
# Date: Thu Oct  3 22:42:23 CEST 2013

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TEST_DESCRIPTION=	Simple OCaml program
TEST_SOURCEDIR=		example/ocaml/wordcount
TEST_SEQUENCE=		preparatives all install

TEST_MATRIX=		WITH_DEBUG WITH_PROFILE COMPILE
TEST_WITH_DEBUG=	yes no
TEST_WITH_PROFILE=	yes no
TEST_COMPILE=		both native_code byte_code

USES+=			compile:${COMPILE}

test:
	test -x ${DESTDIR}${BINDIR}/wordcount
	test -f ${DESTDIR}${MANDIR}/man1/wordcount.1.gz

### End of file `TestProgram.mk'
