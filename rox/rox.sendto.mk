### rox.sendto.mk

# Author: Michael Grünewald
# Date: Jeu 13 mar 2008 21:58:28 CET
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2006-2009, 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


.if !target(__<rox.sendto.mk>__)
__<rox.sendto.mk>__:

SENDTOTYPE!= basename ${.CURDIR}

_SENDTO_SCRIPT_EXTS?=	sh bash pl py

.include "bps.init.mk"
.include "rox.init.mk"

SENDTOMODE?=	${BINMODE}
SENDTODIR?=	${ROXCONFIGDIR}/SendTo/.${SENDTOTYPE}

.for item in ${_SENDTO_SCRIPT_EXTS}
.for sendto in ${SENDTO:M*.${item}}
SENDTONAME_${sendto:T}?=${sendto:T:.${item}=}
.endfor
.endfor

.for sendto in ${SENDTO}
SENDTONAME_${sendto:T}?=${sendto:T}
.endfor

.for sendto in ${SENDTO}
SENDTONAME_${sendto:T}:="${SENDTONAME_${sendto:T}:C/_/ /g}"
.endfor


FILESGROUPS+=SENDTO

.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

.endif#!target(__<rox.sendto.mk>__)

### End of file `rox.sendto.mk'
