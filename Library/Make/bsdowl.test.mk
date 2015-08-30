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

TEST_SEQUENCE?=		clean obj depend build doc install

TEST_ENV+=		DESTDIR='/tmp/${USER}${PACKAGEDIR}$${TESTDIR}$${ARCHITECTUREDIR}$${CONFIGURATIONDIR}'
TEST_ENV+=		USE_SWITCH_CREDENTIALS='no'
TEST_ENV+=		MAKEOBJDIRPREFIX='/tmp/${USER}${PACKAGEDIR}$${TESTDIR}$${ARCHITECTUREDIR}$${CONFIGURATIONDIR}'
TEST_ENV+=		PACKAGELIBRARYCONFIGURATION='${SRCDIR}/testsuite/Library/Configuration'
TEST_ENV+=		PACKAGELIBRARYARCHITECTURE='${SRCDIR}/testsuite/Library/Configuration'
TEST_ENV+=		BSDOWLSRCDIR='${SRCDIR}'
TEST_ENV+=		TESTSRCDIR='${SRCDIR}/testsuite/src'
TEST_ENV+=		TESTDIR='${.CURDIR:C,${SRCDIR}/testsuite,,}/${.ALLSRC:M*.mk:C/.mk$//}'

TEST_ENV_UNSET+=	SRCDIR
TEST_ENV_UNSET+=	WRKDIR
TEST_ENV_UNSET+=	PACKAGE
TEST_ENV_UNSET+=	PACKAGEDIR
TEST_ENV_UNSET+=	OFFICER
TEST_ENV_UNSET+=	VERSION
TEST_ENV_UNSET+=	MODULE
TEST_ENV_UNSET+=	EXTERNAL

MP2EPS=			${SH} ${SRCDIR}/support/mp2eps.sh
MP2PNG=			${SH} ${SRCDIR}/support/mp2png.sh
MP2PDF=			${SH} ${SRCDIR}/support/mp2pdf.sh

.export MP2EPS
.export MP2PNG
.export MP2PDF

.include "generic.test.mk"

### End of file `bsdowl.test.mk'
