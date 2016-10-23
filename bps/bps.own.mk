### bps.own.mk -- Ownership information for canonical file groups

# Auteur: Michael Grünewald
# Date: Fri Feb 10 10:40:49 GMT 2006

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


### DESCRIPTION

# This file provides ownership information for the canonical file
# groups BIN, LIB, SHARE, DOC and MAN.

### IMPLEMENTATION

.if !target(__<bps.init.mk>__)
.error bps.own.mk cannot be included directly.
.endif

.if !target(__<bps.own.mk>__)
__<bps.own.mk>__:

.if ${UID} == 0
_OWN_DIRMODE?=	755
_OWN_BINMODE?=	555
_OWN_DTAMODE?=	444
_OWN_OWN?=	${_BPS_SYSTEMOWN}
_OWN_GRP?=	${_BPS_SYSTEMGRP}
.else
_OWN_DIRMODE?=	750
_OWN_BINMODE?=	550
_OWN_DTAMODE?=	440
_OWN_OWN?=	${USER}
_OWN_GRP?=	${GROUP}
.endif

BINDIR?=	${bindir}
BINMODE?=	${_OWN_BINMODE}
BINOWN?=	${_OWN_OWN}
BINGRP?=	${_OWN_GRP}

LIBDIR?=	${libdir}${PACKAGEDIR}
LIBMODE?=	${_OWN_DTAMODE}
LIBOWN?=	${_OWN_OWN}
LIBGRP?=	${_OWN_GRP}

INCLUDEDIR?=	${includedir}${PACKAGEDIR}
INCLUDEMODE?=	${LIBMODE}
INCLUDEOWN?=	${LIBOWN}
INCLUDEGRP?=	${LIBGRP}

SHAREDIR?=	${datadir}${PACKAGEDIR}
SHAREMODE?=	${_OWN_DTAMODE}
SHAREOWN?=	${_OWN_OWN}
SHAREGRP?=	${_OWN_GRP}

# Note that the value of docdir already mentions PACKAGEDIR, as stated
# in the GNU coding standards, against which we do not want to fight.

DOCDIR?=	${docdir}
DOCMODE?=	${_OWN_DTAMODE}
DOCOWN?=	${_OWN_OWN}
DOCGRP?=	${_OWN_GRP}

MANDIR?=	${mandir}
MANMODE?=	${_OWN_DTAMODE}
MANOWN?=	${_OWN_OWN}
MANGRP?=	${_OWN_GRP}

.endif #!target(__<bps.own.mk>__)

### End of file `bps.own.mk'
