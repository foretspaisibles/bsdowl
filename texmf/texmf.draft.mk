### texmf.draft.mk -- Produce a draft

# Author: Michael Grünewald
# Date: Wed Nov 26 17:42:35 CET 2014

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

.if !target(__<texmf.init.mk>__)
.error texmf.draft.mk cannot be included directly.
.endif


.if !target(__<texmf.draft.mk>__)
__<texmf.draft.mk>__:

DRAFT?=			no
TEXTIMESTAMP!=		date '+%Y-%m-%d'

.if "${DRAFT}" == "no"
.undef TEXDRAFTSTAMP
.else
TEXDRAFTSTAMP?=		-${TEXTIMESTAMP}
.endif

.if defined(TEXDRAFTSTAMP)&&!empty(TEXDRAFTSTAMP)
.for document in ${DOCUMENT}
.for device in ${TEXDEVICE}
.if defined(TEXDOCNAME.${document:T})
TEXDOCNAME.${document:T}:=	${TEXDOCNAME.${document:T}}${TEXDRAFTSTAMP}
.else
TEXDOCNAME.${document:T}=	${document:T}${TEXDRAFTSTAMP}
.endif
.endfor
.endfor
.endif

.endif # !target(__<texmf.draft.mk>__)

### End of file `texmf.draft.mk'
