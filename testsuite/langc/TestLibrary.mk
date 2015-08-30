### TestLibrary.mk -- A very simple static library

# Author: Michael Grünewald
# Date: Thu Nov 20 10:18:05 CET 2014

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

TEST_DESCRIPTION=	Simple C library
TEST_SOURCEDIR=		example/langc/librational
TEST_SEQUENCE=		preparatives all install

TEST_MATRIX=		PROFILE DEBUG COMPILE
TEST_PROFILE=		yes no
TEST_DEBUG=		yes no
TEST_COMPILE=		both shared static

.if !empty(PROFILE:Myes)
USES+=			profile
.endif

.if !empty(DEBUG:Myes)
USES+=			debug
.endif

.if !empty(COMPILE:Mshared)
USES+=			compile:shared
.endif

.if !empty(COMPILE:Mstatic)
USES+=			compile:static
.endif


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

.if !empty(COMPILE:Mstatic)||!empty(COMPILE:Mboth)
test:			test-static
.endif

.if !empty(COMPILE:Mshared)||!empty(COMPILE:Mboth)
test:			test-shared
.endif

test:			test-extras

### End of file `TestLibrary.mk'
