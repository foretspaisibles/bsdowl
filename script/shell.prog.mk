### shell.prog.mk -- Shell programs

# Author: Michael Grünewald
# Date: Fri Nov 21 21:26:09 CET 2014

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

### DESCRIPTION

# Variables:
#
#
#  PROGRAM [not set]
#   Name of the program
#
#   This can actually be a list of programs.  Standard directory
#   variables between `@'s are expanded in the code.
#
#   If PACKAGE is not defined, it will be guessed from PROGRAM if this
#   is a single word or from the last component of SRCDIR otherwise.
#
#
#  SUBR
#   List of script subroutine libraries to install
#
#
#  SUBRDIR [${datadir}${PACKAGEDIR}]
#   List of script libraries to install
#
#   The variables SUBRDIR, SUBRMODE, SUBROWN and
#   SUBRGRP parametrise the installation.
#
#   The SUBRDIR variable defaults to
#   `${datadir}${PACKAGEDIR}` but other sensible locations could
#   follow another pattern, like for instance
#   `${libdir}/perl5/5.12.4${PACKAGEDIR}`.
#
#
#  BINOWN, BINGRP, BINMODE, BINDIR, BINNAME
#   Parameters of the program installation
#
#   See `bps.files.mk` for a closer description of these variables.

THISMODULE=		shell.prog

.if defined(PROG)&&!empty(PROG)
PROGRAM?=		${PROG}
.endif

.if !defined(PROGRAM)||empty(PROGRAM)
.error The shell.prog.mk module expects you to set the PROGRAM variable to a sensible value.
.endif

PRODUCT=		${PROGRAM:C@\.(sh|bash|ksh|csh|awk|sed)$@@}
_PACKAGE_CANDIDATE=	${PRODUCT}
REPLACESUBST+=		${STDREPLACESUBST}
REPLACESUBST+=		BINDIR

.for product in ${PRODUCT}
_MAN_AUTO+=		${product}.1
_MAN_AUTO+=		${product}.8
.endfor

.include "script.main.mk"

### End of file `shell.prog.mk'
