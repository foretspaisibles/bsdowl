### TestLibraryFindlib.mk -- Produce a simple library and install with findlib

# Author: Michael Grünewald
# Date: Sun Nov 30 12:18:24 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TEST_DESCRIPTION=	Simple OCaml library with findlib meta data
TEST_SOURCEDIR=		example/ocaml/newton-meta
TEST_SEQUENCE=		preparatives all install

USES+=			site-lib

test:
	test -f ${DESTDIR}${LIBDIR}/newton.cma
	test -f ${DESTDIR}${LIBDIR}/newton.cmi
	test -f ${DESTDIR}${LIBDIR}/META

### End of file `TestLibraryFindlib.mk'
