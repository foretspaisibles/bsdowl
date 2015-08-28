### TestLibraryDoc.mk -- Produce a simple library with ocamldoc documentation

# Author: Michael Grünewald
# Date: Sat Nov 29 14:47:24 CET 2014

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

TEST_DESCRIPTION=	Simple OCaml library using ocamldoc
TEST_SOURCEDIR=		example/ocaml/newton
TEST_SEQUENCE=		preparatives all install

USES+=			ocamldoc:odoc,html

test:
	test -f ${DESTDIR}${LIBDIR}/newton.cma
	test -f ${DESTDIR}${LIBDIR}/newton.cmi
	test -f ${DESTDIR}${DOCDIR}/html/index.html
	test -f ${.OBJDIR}/newton.odoc

### End of file `TestLibraryDoc.mk'
