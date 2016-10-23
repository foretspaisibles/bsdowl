### texmf.depend.mk -- Automatic generation of dependencies

# Author: Michael Grünewald
# Date: Mon Nov 24 14:04:18 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

.if !defined(THISMODULE)
.error texmf.depend.mk cannot be included directly.
.endif

.if !target(__<texmf.depend.mk>__)
__<texmf.depend.mk>__:

.for document in ${_TEX_DOCUMENT}
.for device in ${TEXDEVICE}
${document}.${device}:	${SRCS.${document:T}}
.endfor
.endfor

do-depend:		.depend.mpost
DISTCLEANFILES+=	.depend.mpost

.depend.mpost:
	@${RM} -f ${.TARGET}
	@${TOUCH} ${.TARGET}
.for figure in ${_MPOST_DOCUMENT}
	@${SED} -n 's@^beginfig(\([0-9][0-9]*\)).*@_MPOST_LIST.${figure:T}+=${figure:T}-\1.mps@p' ${.ALLSRC:M*${figure:T}.mp} >> ${.TARGET}
.endfor

.for document in ${_TEX_DOCUMENT}
.for figure in ${SRCS.${document:T}:M*.mp}
.depend.mpost:		${figure}
.endfor
.endfor

.for document in ${_MPOST_DOCUMENT}
.depend.mpost:		${document}.mp
.endfor

.for document in ${_TEX_DOCUMENT}
.for figure in ${SRCS.${document:T}:M*.mp:.mp=}
${document}.dvi:	${_MPOST_LIST.${figure:T}:.mps=.eps}
${document}.ps:		${_MPOST_LIST.${figure:T}:.mps=.eps}
${document}.pdf:	${_MPOST_LIST.${figure:T}:.mps=.pdf}
.endfor
.endfor

.endif # !target(__<texmf.depend.mk>__)

### End of file `texmf.depend.mk'
