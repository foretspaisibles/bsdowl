### project.mk

# Author: Michael Grünewald
# Date: Jeu 13 mar 2008 21:58:28 CET

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

PACKAGE=		bsdowl
PACKAGEDIR=		/${PACKAGE}
SCRIPTDIR?=		${_BPS_LIBEXEC}${PACKAGEDIR}
SHAREDIR?=		${_BPS_DATADIR}${PACKAGEDIR}
FILESDIR?=		${SHAREDIR}

.include "../../bps/bps.init.mk"
.include "../../texmf/tex.files.mk"
.include "../../bps/bps.files.mk"
.include "../../bps/bps.clean.mk"
.include "../../bps/bps.usertarget.mk"
.include "../../script/script.shell.mk"

### End of file `project.mk'
