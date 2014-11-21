### shell.lib.mk -- Prepare shell library

# Author: Michael Grünewald
# Date: Fri Nov 21 23:01:07 CET 2014

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

# Variables:
#
#
#  LIBRARY [not set]
#   Name of the library
#
#   This can actually be a list of libraries.  Standard directory
#   variables between `@'s are not expanded in the code.
#
#   If PACKAGE is not defined, it will be guessed from LIBRARY if this
#   is a single word or from the last component of SRCDIR otherwise.
#
#
#  SUBROWN, SUBRGRP, SUBRMODE, SUBRDIR, SUBRNAME
#   Parameters of the library installation
#
#   See `bps.files.mk` for a closer description of these variables.

THISMODULE=		shell.lib

.if !defined(LIBRARY)||empty(LIBRARY)
.error The shell.prog.mk module expects you to set the LIBRARY variable to a sensible value.
.endif

PRODUCT=		${LIBRARY:C@\.(sh|bash|ksh|csh|awk|sed|subr)$@@}
_PACKAGE_CANDIDATE=	${PRODUCT}
REPLACE+=		${STDREPLACE}
REPLACE+=		SUBRDIR

.for product in ${PRODUCT}
_MAN_AUTO+=		${product}.3
_MAN_AUTO+=		${product}.8
.endfor

.include "script.main.mk"

### End of file `shell.lib.mk'
