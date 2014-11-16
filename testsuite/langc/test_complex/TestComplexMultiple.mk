### TestComplexMultiple.mk -- Build a complex program

# Author: Michael Grünewald
# Date: Sun Nov 16 11:21:59 CET 2014

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

CONFIGURATIONLIST=	Debug Profile Release
ARCHITECTURELIST=	Native Mingw32

TARGETLIST=		realclean distclean clean
TARGETLIST+=		obj depend build

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

install dist:
	${NOP}

${TARGETLIST}: .PHONY
.for configuration in ${CONFIGURATIONLIST}
.for architecture in ${ARCHITECTURELIST}
	cd ${.CURDIR} && ${MAKE} -f ${.CURDIR}/TestComplex.mk\
	  CONFIGURATIONDIR=/${configuration}\
	  CONFIGURATION=${configuration}\
	  ARCHITECTUREDIR=/${architecture}\
	  ARCHITECTURE=${architecture}\
	  ${.TARGET}
.endfor
.endfor

test:
.for configuration in ${CONFIGURATIONLIST}
.for architecture in ${ARCHITECTURELIST}
.for object in ${OBJECTLIST}
	test -f ${MAKEOBJDIRPREFIX}/${architecture}/${configuration}${.CURDIR}${object}
.endfor
.endfor
.endfor

### End of file `TestComplexMultiple.mk'
