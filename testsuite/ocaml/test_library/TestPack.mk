### TestPack.mk -- Produce a packed library

# Author: Michael Grünewald
# Date: Sat Nov 29 08:06:59 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TEST_DESCRIPTION=	Simple OCaml packed library
TEST_SOURCEDIR=		example/ocaml/newton-pack
TEST_SEQUENCE=		preparatives all install

test:
	test -f ${DESTDIR}${LIBDIR}/newtonlib.cma
	test -f ${DESTDIR}${LIBDIR}/newtonlib.cmi

### End of file `TestPack.mk'
