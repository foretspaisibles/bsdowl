### generic.files.mk -- Install files as assets

# Auteur: Michael Grünewald
# Date: Tue  2 Dec 2014 18:44:57 CET

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

### SYNOPSIS

# FILESGROUPS+=		PLOPFIZZ
# PLOPFIZZDIR=		${datadir}${PACKAGEDIR}
# PLOPFIZZMODE=		${SHAREMODE}
# PLOPFIZZOWN=		${SHAREOWN}
# PLOPFIZZGRP=		${SHAREGRP}
# PLOPFIZZ=		data.pf other.pf
# PLOPFIZZMODE.data.pf=	400


### DESCRIPTION

# This file allows the installation of files.  It is a standalone form
# of the file bps.files.mk, whose documentation we refer to.


THISMODULE=		generic.files

.if !empty(FILESGROUPS)
_GENERIC_FILESGROUPS+=	${FILESGROUPS}
.endif
_GENERIC_FILESGROUPS+=	FILES BIN LIB INCLUDE DOC SHARE MAN

.for group in ${_GENERIC_FILESGROUPS}
.if defined(${group})&&!empty(${group})
PRODUCT+=		${${group}}
.endif
.endfor

.for product in ${PRODUCT}
_MAN_AUTO+=		${product}.5
_MAN_AUTO+=		${product}.8
.endfor

.include "bps.init.mk"
.include "bps.man.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

### End of file `generic.files.mk'
