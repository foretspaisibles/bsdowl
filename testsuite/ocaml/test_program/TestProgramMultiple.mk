### TestProgramMultiple.mk -- Counting characters and lines in a file

# Author: Michael Grünewald
# Date: Thu Nov  6 17:51:09 CET 2014

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

${TARGETLIST}: .PHONY
.for configuration in ${CONFIGURATIONLIST}
	cd ${.CURDIR} && ${MAKE} -f ${.CURDIR}/TestProgram.mk\
		CONFIGURATIONDIR=/${configuration}\
		CONFIGURATION=${configuration}\
		${.TARGET}
.endfor

test:
.for configuration in ${CONFIGURATIONLIST}
	test -x ${MAKEOBJDIRPREFIX}/${configuration}${.CURDIR}/wordcount
	test -f ${MAKEOBJDIRPREFIX}/${configuration}${.CURDIR}/wordcount.1.gz
.endfor

### End of file `TestProgramMultiple.mk'
