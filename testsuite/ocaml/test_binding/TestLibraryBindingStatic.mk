### TestLibraryBindingStatic.mk -- Produce a C static binding

# Author: Michael Grünewald
# Date: Fri Jan  9 10:42:28 CET 2015

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

PACKAGE=		ocaml-rational
VERSION=		1.0.0
OFFICER=		michipili@gmail.com

APIVERSION=		1
LIBVERSION=		${APIVERSION}.0.0

MODULE=			langc.lib:stubs
MODULE+=		langc.lib:upstream
MODULE+=		ocaml.lib:srcs
MODULE+=		ocaml.prog:testsuite

test-static:
	test -f ${DESTDIR}${LIBDIR}/librational.a

.if defined(.MAKE.OS)&& ${.MAKE.OS} == Darwin
test-shared:
	test -f ${DESTDIR}${LIBDIR}/librational.dylib.${LIBVERSION}
.else
test-shared:
	test -f ${DESTDIR}${LIBDIR}/librational.so.${LIBVERSION}
.endif

test-extras:
	test -f ${DESTDIR}${INCLUDEDIR}/rational.h
	test -f ${DESTDIR}${INCLUDEDIR}/rational_trace.h
	test -f ${DESTDIR}${MANDIR}/man3/librational.3.gz

test-upstream: test-static test-shared test-extras

.if defined(.MAKE.OS)&& ${.MAKE.OS} == Darwin
test-stubs:
	test -f ${DESTDIR}${LIBDIR}/librational_stubs.dylib
.else
test-stubs:
	test -f ${DESTDIR}${LIBDIR}/librational_stubs.so
.endif


test-testsuite:
	test -x ${DESTDIR}${BINDIR}/test_rational
	LD_LIBRARY_PATH=${DESTDIR}${LIBDIR} ${DESTDIR}${BINDIR}/test_rational

test: test-upstream test-stubs test-testsuite

.include "generic.project.mk"

### End of file `TestLibraryBindingStatic.mk'
