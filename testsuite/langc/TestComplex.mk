### TestComplex.mk -- A complex heat generating program

# Author: Michael Grünewald
# Date: Fri Nov 14 10:56:08 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TEST_DESCRIPTION=	Complex C software made of two libraries and a program
TEST_SOURCEDIR=		example/langc/heat
TEST_SEQUENCE=		preparatives all install
TEST_MATRIX=		CONFIGURATION

TEST_CONFIGURATION=	Release

test-librational:
	test -f ${DESTDIR}${LIBDIR}/librational.a
	test -f ${DESTDIR}${INCLUDEDIR}/rational.h
	test -f ${DESTDIR}${INCLUDEDIR}/rational_trace.h
	test -f ${DESTDIR}${MANDIR}/man3/librational.3.gz

test-libfibonacci:
	test -f ${DESTDIR}${LIBDIR}/libfibonacci.a
	test -f ${DESTDIR}${INCLUDEDIR}/fibonacci.h
	test -f ${DESTDIR}${MANDIR}/man3/libfibonacci.3.gz

test-goldenratio:
	test -x ${DESTDIR}${BINDIR}/goldenratio

test-dist:
	test -f ${PACKAGE}-${VERSION}.tar.gz
	test -f ${PACKAGE}-${VERSION}.tar.gz.sig
	test -f ${PACKAGE}-${VERSION}.tar.bz2
	test -f ${PACKAGE}-${VERSION}.tar.bz2.sig
.if!(defined(.MAKE.OS)&&${.MAKE.OS} == Darwin)
	test -f ${PACKAGE}-${VERSION}.tar.xz
	test -f ${PACKAGE}-${VERSION}.tar.xz.sig
.endif

test: test-librational
test: test-libfibonacci
test: test-goldenratio

.if !empty(WITH_TESTSUITE_GPG:Myes)
test: test-dist
.endif


### End of file `TestComplex.mk'
