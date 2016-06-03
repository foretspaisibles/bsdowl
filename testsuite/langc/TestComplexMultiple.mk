### TestComplexMultiple.mk -- Build a complex program

# Author: Michael Grünewald
# Date: Sun Nov 16 11:21:59 CET 2014

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

TEST_DESCRIPTION=	Complex C software with multiple configurations
TEST_SOURCEDIR=		example/langc/heat
TEST_SEQUENCE=		preparatives all
TEST_MATRIX=		CONFIGURATION ARCHITECTURE

TEST_CONFIGURATION=	Debug Profile Release
TEST_ARCHITECTURE=	Native

.if "${WITH_TESTSUITE_MINGW32}" == "yes"
TEST_ARCHITECTURE+=	Mingw32
.endif

OBJECTLIST=		/librational/librational.3.gz
OBJECTLIST+=		/librational/rational_operation.o
OBJECTLIST+=		/librational/rational_trace.o
OBJECTLIST+=		/librational/librational.a
OBJECTLIST+=		/librational/rational_print.o
OBJECTLIST+=		/libfibonacci/fibonacci.o
OBJECTLIST+=		/libfibonacci/libfibonacci.3.gz
OBJECTLIST+=		/libfibonacci/libfibonacci.a
OBJECTLIST+=		/goldenratio/goldenratio
OBJECTLIST+=		/goldenratio/goldenratio.o

test:
.if defined(MAKEOBJDIR)
.for object in ${OBJECTLIST}
	test -f ${BSDOWL_TESTDIR}/${BSDOWL_BATCHNAME}/${BSDOWL_TESTID}/var/obj${CONFIGURATIONDIR}${ARCHITECTUREDIR}${.CURDIR:S@^${BSDOWL_TESTDIR}/${BSDOWL_BATCHNAME}/${BSDOWL_TESTID}/var/src@@}${object}
.endfor
.elif defined(MAKEOBJDIRPREFIX)
.for object in ${OBJECTLIST}
	test -f ${BSDOWL_TESTDIR}/obj/${BSDOWL_TESTID}${CONFIGURATIONDIR}${ARCHITECTUREDIR}${.CURDIR}${object}
.endfor
.else
	@${FAIL} The test ${BSDOWL_TESTID} must run with MAKEOBJDIR or MAKEOBJDIRPREFIX set.
	@false
.endif

### End of file `TestComplexMultiple.mk'
