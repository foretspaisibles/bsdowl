### TestInternalDependency.mk -- Validate internal dependencies

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

TEST_DESCRIPTION=	Internal dependencies in an OCaml project
TEST_SOURCEDIR=		example/ocaml/heat

.if "${WITH_TESTSUITE_FINDLIB}" == "yes"
TEST_SEQUENCE=		preparatives all edit all install
.else
TEST_SEQUENCE=		IGNORE
.endif

TEST_MATRIX=		COMPILE
TEST_COMPILE=		both native_code byte_code

USES+=			compile:${COMPILE}

edit:
	${SED_INPLACE} -e "$$(printf '$$a\\\nval x : unit\n')" ${.CURDIR}/fibonacci/fibonacci.mli
	${SED_INPLACE} -e "$$(printf '$$a\\\nlet x = ()\n')" ${.CURDIR}/fibonacci/fibonacci.ml

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

### End of file `TestInternalDependency.mk'
