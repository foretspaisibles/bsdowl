### latex.files.mk -- Install LaTeX macro files

# Author: Michael Grünewald
# Date: Fri Nov 28 10:20:39 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

### DESCRIPTION

THISMODULE=		latex.files

.if !defined(FILES)||empty(FILES)
.error The latex.files.mk module expects you to set the FILES\
	  variable to a sensible value.
.endif

_PACKAGE_CANDIDATE=	${FILES}
PRODUCT=		${FILES}

.if !empty(DOC)
PRODUCT+=		${DOC}
.endif

FILESDIR?=		${datarootdir}/texmf-local/tex/latex${PACKAGEDIR}
DOCDIR?=		${datarootdir}/texmf-local/doc/latex${PACKAGEDIR}

.include "bps.init.mk"
.include "bps.man.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

### End of file `latex.files.mk'
