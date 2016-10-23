### TestToplevelCustom.mk -- Prepare an OCaml custom toplevel

# Author: Michael Grünewald
# Date: Sat Jan  3 16:18:30 CET 2015

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TEST_DESCRIPTION=	Modified OCaml toplevel with custom C stubs
TEST_SOURCEDIR=		example/ocaml/greetingtop
TEST_SEQUENCE=		preparatives all install

test:
	test -x ${DESTDIR}${BINDIR}/custom_toplevel

### End of file `TestToplevel.mk'
