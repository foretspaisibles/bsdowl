### TestPerlModule.mk -- Prepare a simple Perl module

# Author: Michael Grünewald
# Date: Fri Nov 21 15:20:46 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


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
	test -f ${DESTDIR}${MANDIR}/man3p/Selftest.3pm.gz
	perl -I ${DESTDIR}${PERLLIBDIR} -e ${PERLTEST}

### End of file `TestPerlModule.mk'
