### rox.sendto.mk

# Author: Michaël Grünewald
# Date: Jeu 13 mar 2008 21:58:28 CET
# Lang: fr_FR.ISO8859-15

# $Id$

# Copyright (c) 2006, 2007, 2008, Michaël Grünewald
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#    1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#    2. Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#
#    3. The name of the author may not be used to endorse or promote
#    products derived from this software without specific prior written
#    permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.


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
