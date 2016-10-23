### perl.init.mk -- Initialisation for Perl support

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

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
