### TestComplex.mk -- Mini project

# Author: Michael Grünewald
# Date: Sun Oct 13 10:50:45 CEST 2013

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

TEST_DESCRIPTION=	Complex OCaml program
TEST_SOURCEDIR=		example/ocaml/heat

.if "${WITH_TESTSUITE_FINDLIB}" == "yes"
TEST_SEQUENCE=		preparatives all install
.else
TEST_SEQUENCE=		IGNORE
.endif

TEST_MATRIX=		WITH_DEBUG WITH_PROFILE COMPILE
TEST_WITH_DEBUG=	yes no
TEST_WITH_PROFILE=	yes no
TEST_COMPILE=		both native_code byte_code

USES+=			compile:${COMPILE}

test-lib:
.if !empty(COMPILE:Mboth)||!empty(COMPILE:Mbyte_code)
	test -f ${DESTDIR}${LIBDIR}/newton.cma
	test -f ${DESTDIR}${LIBDIR}/fibonacci.cma
.endif
.if !empty(COMPILE:Mboth)||!empty(COMPILE:Mnative_code)
	test -f ${DESTDIR}${LIBDIR}/newton.a
	test -f ${DESTDIR}${LIBDIR}/newton.cmxa
	test -f ${DESTDIR}${LIBDIR}/fibonacci.a
	test -f ${DESTDIR}${LIBDIR}/fibonacci.cmxa
.endif
	test -f ${DESTDIR}${LIBDIR}/fibonacci.cmi
	test -f ${DESTDIR}${LIBDIR}/newton.cmi

test-prog:
	test -f ${DESTDIR}${BINDIR}/golden_ratio

test-doc:
	test -f ${DESTDIR}${DOCDIR}/html/index.html

test:	test-lib test-doc test-prog

### End of file `TestComplex.mk'
