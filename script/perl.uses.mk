### perl.uses.mk -- Options for Perl scripts

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


.if !defined(THISMODULE)
.error perl.uses.mk cannot be included directly.
.endif

.if !target(__<perl.uses.mk>__)
__<perl.uses.mk>__:

.if!empty(_USES_perl_ARGS:M[0-9]*)
PERLVERSION=		${_USES_perl_ARGS:M[0-9]*}
.endif

.endif # !target(__<perl.uses.mk>__)

### End of file `perl.uses.mk'
