### TestComplex.mk -- A complex heat generating program

# Author: Michael Grünewald
# Date: Fri Nov 14 10:56:08 CET 2014

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

PACKAGE=	heat
VERSION=	0.1-current
OFFICER?=	michipili@gmail.com

MODULE=		langc.lib:librational
MODULE+=	langc.lib:libfibonacci
MODULE+=	langc.prog:goldenratio

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

.if "${WITH_TESTSUITE_GPG}" == "yes"
test: test-dist
.endif

.include "generic.project.mk"

### End of file `TestComplex.mk'
