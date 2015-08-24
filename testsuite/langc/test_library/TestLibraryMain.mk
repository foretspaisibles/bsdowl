### TestLibraryMain.mk -- A very simple static library

# Author: Michael Grünewald
# Date: Fri Nov  7 10:16:01 CET 2014

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

LIBRARY=		rational

APIVERSION=		1
LIBVERSION=		${APIVERSION}.0.0

SRCS=			rational.h
SRCS+=			rational_trace.h
SRCS+=			rational_trace.c
SRCS+=			rational_operation.c
SRCS+=			rational_print.c

MAN=			librational.3

DIRS=			${BSDOWLSRCDIR}/example/langc/librational
.PATH:			${DIRS}

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

.include "langc.lib.mk"

### End of file `TestLibraryMain.mk'
