### TestLibrary.mk -- Produce a simple library

# Author: Michael Grünewald
# Date: Sat Nov 29 14:47:24 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


TEST_DESCRIPTION=	Simple OCaml library
TEST_SOURCEDIR=		example/ocaml/newton
TEST_SEQUENCE=		preparatives all install

TEST_MATRIX=		WITH_DEBUG WITH_PROFILE COMPILE
TEST_WITH_DEBUG=	yes no
TEST_WITH_PROFILE=	yes no
TEST_COMPILE=		both native_code byte_code

USES+=			compile:${COMPILE}

test:
	test -f ${DESTDIR}${LIBDIR}/newton.cmi
.if !empty(COMPILE:Mboth)||!empty(COMPILE:Mbyte_code)
	test -f ${DESTDIR}${LIBDIR}/newton.cma
.endif
.if !empty(COMPILE:Mboth)||!empty(COMPILE:Mnative_code)
	test -f ${DESTDIR}${LIBDIR}/newton.a
	test -f ${DESTDIR}${LIBDIR}/newton.cmxa
.endif

### End of file `TestLibrary.mk'
