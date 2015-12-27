### TestPerlModule.mk -- Prepare a simple Perl module

# Author: Michael Grünewald
# Date: Fri Nov 21 15:20:46 CET 2014

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


### SYNOPSIS

### DESCRIPTION

TEST_DESCRIPTION=	Simple perl module
TEST_SOURCEDIR=		example/script/perl/selftest
TEST_SEQUENCE=		preparatives all install

PERLLIBDIR=		${LIBDIR}/perl5
PERLTEST='\
use Selftest;\
selftest;\
'

test:
	test -f ${DESTDIR}${PERLLIBDIR}/Selftest.pm
	test -f ${DESTDIR}${MANDIR}/man3/Selftest.3pm.gz
	perl -I ${DESTDIR}${PERLLIBDIR} -e ${PERLTEST}

### End of file `TestPerlModule.mk'
