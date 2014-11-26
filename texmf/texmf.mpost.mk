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

.for document in ${_TEX_DOCUMENT}
.for figure in ${SRCS.${document:T}:M*.mp}
_MPOST_DOCUMENT+=	${figure:.mp=}
.endfor
.endfor
_MPOST_DOCUMENT:=	${_MPOST_DOCUMENT:O:u}

_MPOST_MPSTOOL=		${_MPOST_TOOL}
_MPOST_MPSTOOL+=	-s 'prologues=3'
_MPOST_MPSTOOL+=	-s 'outputtemplate="%j-%c.mps"'

_MPOST_SVGTOOL=		${_MPOST_TOOL}
_MPOST_SVGTOOL+=	-s 'prologues=3'
_MPOST_SVGTOOL+=	-s 'outputformat="svg"'
_MPOST_SVGTOOL+=	-s 'outputtemplate="%j-%c.svg"'

.for document in ${_TEX_DOCUMENT}
.for figure in ${SRCS.${document:T}:M*.mp:.mp=}
CLEANFILES+=		${figure}.log
.if !empty(_MPOST_LIST.${figure:T})
CLEANFILES+=		${_MPOST_LIST.${figure:T}}
.if !empty(TEXDEVICE:Mdvi)||!empty(TEXDEVICE:M*ps)
CLEANFILES+=		${_MPOST_LIST.${figure:T}:.mps=.eps}
.endif
.if !empty(TEXDEVICE:Mpdf)
CLEANFILES+=		${_MPOST_LIST.${figure:T}:.mps=.pdf}
.endif
.endif
.endfor
.endfor

.for figure in ${_MPOST_DOCUMENT}
.if !empty(_MPOST_LIST.${figure:T})
${_MPOST_LIST.${figure:T}}: ${figure}.mp
	${_MPOST_MPSTOOL} ${.ALLSRC}
CLEANFILES+=		${figure}.log
.if !empty(MPDEVICE:Nsvg)
CLEANFILES+=		${_MPOST_LIST.${figure:T}}
.endif
.if !empty(MPDEVICE:Meps)
CLEANFILES+=		${_MPOST_LIST.${figure:T}:.mps=.eps}
.endif
.if !empty(MPDEVICE:Mpdf)
CLEANFILES+=		${_MPOST_LIST.${figure:T}:.mps=.pdf}
.endif
.if !empty(MPDEVICE:Mpng)
CLEANFILES+=		${_MPOST_LIST.${figure:T}:.mps=.png}
.endif
.endif
.endfor

.if !empty(MPDEVICE:Msvg)
.for figure in ${_MPOST_DOCUMENT}
.if !empty(_MPOST_LIST.${figure:T})
${_MPOST_LIST.${figure:T}:.mps=.svg}: ${figure}.mp
	${_MPOST_SVGTOOL} ${.ALLSRC}
CLEANFILES+=		${_MPOST_LIST.${figure:T}:.mps=.svg}
.endif
.endfor
.endif

.endif # !target(__<texmf.mpost.mk>__)

.if !target(display-mpost)
display-mpost:
	${INFO} 'Display METAPOST information'
.for displayvar in _MPOST_DOCUMENT
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.endif


### End of file `texmf.mpost.mk'
