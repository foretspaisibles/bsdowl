### perl.init.mk -- Initialisation for Perl support

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2015 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

.if !defined(THISMODULE)
.error perl.init.mk cannot be included directly.
.endif

.if !target(__<perl.init.mk>__)
__<perl.init.mk>__:

.if defined(PERLPACKAGE)
PERLPACKAGEDIR?=	${PERLPACKAGE:C@::@/@g:C@^@/@}
.else
PERLPACKAGEDIR?=
.endif

MANSECTIONS?=		3pm 8pm

.include "bps.init.mk"
.include "perl.uses.mk"

PERLVERSION?=		5
PERLLIBDIR?=		${PREFIX}/lib/perl${PERLVERSION}${PERLPACKAGEDIR}

.endif # !target(__<perl.init.mk>__)

### End of file `perl.init.mk'
