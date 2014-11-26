### texmf.mpost.mk -- Support for METAPOST

# Author: Michael Grünewald
# Date: Wed Nov 26 18:50:13 CET 2014

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
.error texmf.mpost.mk cannot be included directly.
.endif


.if !target(__<texmf.mpost.mk>__)
__<texmf.mpost.mk>__:

.for document in ${DOCUMENT}
.for figure in ${SRCS.${document:T}:M*.mp}
_MPOST_SRC+=		${figure}
.endfor
.endfor
_MPOST_SRC:=		${_MPOST_SRC:O:u}

_MPOST_MPSTOOL=		${_MPOST_TOOL}
_MPOST_MPSTOOL+=	-s 'prologues=3'
_MPOST_MPSTOOL+=	-s 'outputtemplate="%j-%c.mps"'

.for figure in ${_MPOST_SRC}
${_MPOST_LIST.${figure:T}}: ${figure}
	${_MPOST_MPSTOOL} ${.ALLSRC}

CLEANFILES+=		${_MPOST_LIST.${figure:T}}
.if !empty(TEXDEVICE:Mdvi)||!empty(TEXDEVICE:M*ps)
CLEANFILES+=		${_MPOST_LIST.${figure:T}:.mps=.eps}
.endif
.if !empty(TEXDEVICE:Mpdf)
CLEANFILES+=		${_MPOST_LIST.${figure:T}:.mps=.pdf}
.endif
.endfor

.endif # !target(__<texmf.mpost.mk>__)

### End of file `texmf.mpost.mk'
