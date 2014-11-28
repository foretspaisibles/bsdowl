### mpost.files.mk -- Install Metapost macro files

# Author: Michael Grünewald
# Date: Fri Nov 28 12:15:11 CET 2014

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

THISMODULE=		mpost.files

.if !defined(FILES)||empty(FILES)
.error The mpost.files.mk module expects you to set the FILES\
	  variable to a sensible value.
.endif

_PACKAGE_CANDIDATE=	${FILES}
PRODUCT=		${FILES}

.if !empty(DOC)
PRODUCT+=		${DOC}
.endif

FILESDIR?=		${datarootdir}/texmf-local/metapost${PACKAGEDIR}
DOCDIR?=		${datarootdir}/texmf-local/doc/metapost${PACKAGEDIR}

.include "bps.init.mk"
.include "bps.man.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

### End of file `mpost.files.mk'
