### bsdowl.test.mk

# Author: Michael Grünewald
# Date: Fri Mai  9 14:47:47 CEST 2008

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

.include "bps.init.mk"

all configure depend build doc:
	${NOP}
test: do-test
clean: do-clean
distclean: clean
realclean: distclean

MP2EPS=			${SH} ${SRCDIR}/support/mp2eps.sh
MP2PNG=			${SH} ${SRCDIR}/support/mp2png.sh
MP2PDF=			${SH} ${SRCDIR}/support/mp2pdf.sh

.export MP2EPS
.export MP2PNG
.export MP2PDF

.for variable in SRCDIR WRKDIR\
	  PACKAGE PACKAGEDIR OFFICER VERSION MODULE EXTERNAL
MAKETEST+=		unset ${variable};
.endfor

MAKETEST+=		${ENVTOOL}
MAKETEST+=		DESTDIR='/tmp/${USER}${PACKAGEDIR}$${TESTDIR}$${ARCHITECTUREDIR}$${CONFIGURATIONDIR}'
MAKETEST+=		PREFIX='/usr/local'
MAKETEST+=		USE_SWITCH_CREDENTIALS='no'
MAKETEST+=		MAKEOBJDIRPREFIX='/tmp/${USER}${PACKAGEDIR}$${TESTDIR}$${ARCHITECTUREDIR}$${CONFIGURATIONDIR}'
MAKETEST+=		PACKAGELIBRARYCONFIGURATION='${SRCDIR}/testsuite/Library/Configuration'
MAKETEST+=		PACKAGELIBRARYARCHITECTURE='${SRCDIR}/testsuite/Library/Configuration'
MAKETEST+=		BSDOWLSRCDIR='${SRCDIR}'
MAKETEST+=		TESTSRCDIR='${SRCDIR}/testsuite/src'
MAKETEST+=		TESTDIR='${.CURDIR:C,${SRCDIR}/testsuite,,}/${.ALLSRC:M*.mk:C/.mk$//}'
MAKETEST+=		${MAKE}

TESTSEQUENCE?=		clean obj depend build doc install

.ORDER:			${TEST:C@^@do-test-@}
.ORDER:			${TEST:C@$@.done@}

.for test in ${TEST}
.if exists(${test}.mk)
do-test: do-test-${test}
do-test-${test}: ${test}.done
${test}.done: ${test}.mk
.for step in ${TESTSEQUENCE}
	${INFO} ${SUBDIR_PREFIX}${test} '(${step})'
	@${MAKETEST} -f ${.ALLSRC:M*.mk} ${step}
.endfor
	${INFO} ${SUBDIR_PREFIX}${test} '(test)'
	@${MAKETEST} -f ${.ALLSRC:M*.mk} test
	touch ${test}.done
do-clean: do-clean-${test}
do-clean-${test}: ${test}.mk .PHONY
	${INFO} ${SUBDIR_PREFIX}${test} '(clean)'
	@${RM} -f ${test}.done
	@${MAKETEST} -f ${.ALLSRC:M*.mk} realclean
.else
.error ${test}: Test is not defined.
.endif
.endfor

display-makeflags:
	@printf '.MAKEFLAGS: %s\n' ${MAKEFLAGS}

.include "bps.usertarget.mk"

### End of file `bsdowl.test.mk'
