### bps.test-expected.mk -- Implement got/expected tests

# Author: Michael Grünewald
# Date: Fri Dec  5 10:01:42 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

# Uses:
#
#
#  test:expected
#   This module defines got/expected tests

.if !target(__<bps.init.mk>__)
.error bps.test-expected.mk cannot be included directly.
.endif

.if !target(__<bps.test-expected.mk>__)
__<bps.test-expected.mk>__:

.if!empty(_USES_OPTIONS:Mtest)&&!empty(_USES_test_ARGS:Mexpected)
install:: .PHONY
	${NOP}

.if defined(PRODUCT)
TEST?=			${PRODUCT}
.endif

.if!defined(TEST)
.error Cannot figure out how to run tests.
.endif

.if defined(TEST_ENV)&&!empty(TEST_ENV)
.export ${TEST_ENV}
.endif

.for test in ${TEST}
.if !target(${test}.got)
${test}.got: ${test}
	./${test} > ${.TARGET}
.endif
CLEANFILES+=		${test}.got
CLEANFILES+=		${test}.done
${test}.done: ${test}.got ${test}.expected
	diff -u ${.ALLSRC:M*.expected} ${.ALLSRC:M*.got}\
	  || (${RM} -f ${.ALLSRC:M*.got}; exit 1)
	${TOUCH} ${.TARGET}

do-test-expected: ${test}.done
.endfor

do-test: do-test-expected
.endif

.endif # !target(__<bps.test-expected.mk>__)

### End of file `bps.test-expected.mk'
