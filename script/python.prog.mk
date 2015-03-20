### python.prog.mk -- Prepare Python programs

# Author: Michael Grünewald
# Date: Sat Nov 22 09:44:59 CET 2014

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
#  BINOWN, BINGRP, BINMODE, BINDIR, BINNAME
#   Parameters of the program installation
#
#   See `bps.files.mk` for a closer description of these variables.
#
#
#  PYTHON
#   Path to the interpreter to be used

THISMODULE=		python.prog

.if defined(PROG)&&!empty(PROG)
PROGRAM?=		${PROG}
.endif

.if !defined(PROGRAM)||empty(PROGRAM)
.error The python.prog.mk module expects you to set the PROGRAM variable to a sensible value.
.endif

PRODUCT=		${PROGRAM:C@\.py$@@}
_PACKAGE_CANDIDATE=	${PRODUCT}
REPLACESUBST+=		PYTHON
REPLACESUBST+=		${STDREPLACESUBST}
REPLACESUBST+=		BINDIR

.for product in ${PRODUCT}
_MAN_AUTO+=		${product}.1
_MAN_AUTO+=		${product}.8
.endfor

PYTHON?=		/usr/bin/env python

.include "script.main.mk"

### End of file `python.prog.mk'
