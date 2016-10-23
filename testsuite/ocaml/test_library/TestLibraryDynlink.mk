### TestLibraryDynlink.mk -- Produce a simple library and install with findlib

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

TEST_DESCRIPTION=	Simple OCaml dynlink plugin
TEST_SOURCEDIR=		example/ocaml/newton
TEST_SEQUENCE=		preparatives all install

USES+=			dynlink

COMPILE=		native

test:
	test -f ${DESTDIR}${LIBDIR}/newton.cmxa
	test -f ${DESTDIR}${LIBDIR}/newton.cmxs
	test -f ${DESTDIR}${LIBDIR}/newton.cmi

### End of file `TestLibraryDynlink.mk'
