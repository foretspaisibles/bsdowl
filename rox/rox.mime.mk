### rox.mime.mk

# Author: Michaël Le Barbier Grünewald
# Date: Jeu 13 mar 2008 21:58:28 CET
# Lang: fr_FR.ISO8859-15

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) Michaël Le Barbier Grünewald - 2006-2009
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


.if !target(__<rox.mime.mk>__)
__<rox.mime.mk>__:

_MIME_SCRIPT_EXTS?=	sh bash pl py

.include "bps.init.mk"
.include "rox.init.mk"

MIMEMODE?=	${BINMODE}
MIMEDIR?=	${ROXCONFIGDIR}/MIME-types

.for item in ${_MIME_SCRIPT_EXTS}
.for mime in ${MIME:M*.${item}}
MIMENAME_${mime:T}?=${mime:T:.${item}=}
.endfor
.endfor

FILESGROUPS+=MIME

.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

.endif#!target(__<rox.mime.mk>__)

### End of file `rox.mime.mk'
