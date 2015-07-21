### TestComplexMultiple.mk -- Build a complex project

# Author: Michael Grünewald
# Date: Sun Nov 30 16:07:10 CET 2014

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
TARGETLIST=		realclean distclean clean
TARGETLIST+=		obj depend build doc install

prefix=			/opt/bsdowl

.export:		prefix

${TARGETLIST}: .PHONY
.for configuration in ${CONFIGURATIONLIST}
	cd ${.CURDIR} && ${MAKE} -f ${.CURDIR}/TestComplex.mk\
		CONFIGURATIONDIR=/${configuration}\
		CONFIGURATION=${configuration}\
		${.TARGET}
.endfor

LIBDIR=			${prefix}/lib/golden_ratio
BINDIR=			${prefix}/bin
DOCDIR=			${prefix}/share/doc/golden_ratio

.for configuration in ${CONFIGURATIONLIST}
testdir:=		${MAKEOBJDIRPREFIX}/${configuration}
test-${configuration}:
	test -f ${testdir}${LIBDIR}/fibonacci.cmi
	test -f ${testdir}${LIBDIR}/newton.cmi
	test -f ${testdir}${BINDIR}/golden_ratio
	test -f ${testdir}${DOCDIR}/html/index.html

test:			test-${configuration}
.endfor

test-Release-lib:
	test -f ${MAKEOBJDIRPREFIX}/Release${LIBDIR}/fibonacci.cmxa
	test -f ${MAKEOBJDIRPREFIX}/Release${LIBDIR}/fibonacci.a
	test -f ${MAKEOBJDIRPREFIX}/Release${LIBDIR}/newton.cmxa
	test -f ${MAKEOBJDIRPREFIX}/Release${LIBDIR}/newton.a

test-Debug-lib:
	test -f ${MAKEOBJDIRPREFIX}/Debug${LIBDIR}/fibonacci.cma
	test -f ${MAKEOBJDIRPREFIX}/Debug${LIBDIR}/newton.cma

test-Profile-lib:
	test -f ${MAKEOBJDIRPREFIX}/Profile${LIBDIR}/fibonacci.cma
	test -f ${MAKEOBJDIRPREFIX}/Profile${LIBDIR}/newton.cma

test: test-Release-lib test-Debug-lib test-Profile-lib

### End of file `TestComplexMultiple.mk'
