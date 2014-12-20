### generic.test.mk -- Generic test facility

# Author: Michael Grünewald
# Date: Fri Mai  9 14:47:47 CEST 2008

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

# Variables:
#
#
#  TEST [not set]
#   The list of test to run
#
#
#  TEST_ENV_UNSET [not set]
#   List of variables to unset in test's environment
#
#
#  TEST_ENV [not set]
#   List of variables to export to test's environment
#
#
#  TEST_SEQUENCE [clean obj depend build]
#   List of targets to call for tests, before we call test itself


THISMODULE=		generic.test

.if !defined(TEST)||empty(TEST)
.error The generic.test.mk module expects you to set the TEST variable to a sensible value.
.endif

.include "bps.init.mk"

all configure depend build doc:
	${NOP}
test: do-test
clean: do-clean
distclean: clean
realclean: distclean

.if defined(TEST_ENV_UNSET)
.for variable in ${TEST_ENV_UNSET}
TESTTOOL+=		unset ${variable};
.endfor
.endif

.if defined(TEST_ENV)
TESTTOOL+=		${ENVTOOL}
.if!empty(TEST_ENV:M*=*)
TESTTOOL+=		${TEST_ENV:M*=*}
.endif
.for variable in ${TEST_ENV:N*=*}
TESTTOOL+=		${variable}=${${variable}:Q}
.endfor
.endif
TESTTOOL+=		${MAKE}

TEST_SEQUENCE?=		realclean obj depend build

.ORDER:			${TEST:C@^@do-test-@}
.ORDER:			${TEST:C@$@.done@}

.for test in ${TEST}
.if exists(${test}.mk)
do-test: do-test-${test}
do-test-${test}: ${test}.done
${test}.done: ${test}.mk
.for step in ${TEST_SEQUENCE}
	${INFO} ${SUBDIR_PREFIX}${test} '(${step})'
	@${TESTTOOL} -f ${.ALLSRC:M*.mk} ${step}
.endfor
	${INFO} ${SUBDIR_PREFIX}${test} '(test)'
	@${TESTTOOL} -f ${.ALLSRC:M*.mk} test
	touch ${test}.done
do-clean: do-clean-${test}
do-clean-${test}: ${test}.mk .PHONY
	${INFO} ${SUBDIR_PREFIX}${test} '(clean)'
	@${RM} -f ${test}.done
	@${TESTTOOL} -f ${.ALLSRC:M*.mk} realclean
.else
.error ${test}: Test is not defined.
.endif
.endfor

.include "bps.usertarget.mk"

### End of file `bsdowl.test.mk'
