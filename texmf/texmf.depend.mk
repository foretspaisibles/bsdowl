### texmf.depend.mk -- Automatic generation of dependencies

# Author: Michael Grünewald
# Date: Mon Nov 24 14:04:18 CET 2014

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

.if !defined(THISMODULE)
.error texmf.depend.mk cannot be included directly.
.endif

.if !target(__<texmf.depend.mk>__)
__<texmf.depend.mk>__:

.for document in ${DOCUMENT}
.for device in ${TEXDEVICE}
${document}.${device}:	${SRCS.${document:T}}
.endfor
.endfor

.for document in ${DOCUMENT}
.for device in ${TEXDEVICE}
${document}.${device}:	${SRCS.${document:T}}
.endfor
.endfor

do-depend:		.depend.mpost
DISTCLEANFILES+=	.depend.mpost

.depend.mpost:
	@${RM} -f ${.TARGET}
	@${TOUCH} ${.TARGET}
.for document in ${DOCUMENT}
.for figure in ${SRCS.${document:T}:M*.mp}
	@${SED} -n 's@^beginfig(\([0-9][0-9]*\)).*@_MPOST_LIST.${figure:T}+=${figure:.mp=}-\1.mps@p' ${.ALLSRC} >> ${.TARGET}
.endfor
.endfor

.for document in ${DOCUMENT}
.for figure in ${SRCS.${document:T}:M*.mp}
.depend.mpost:		${figure}
.endfor
.endfor

.for document in ${DOCUMENT}
.for figure in ${SRCS.${document:T}:M*.mp}
${document}.dvi:	${_MPOST_LIST.${figure:T}:.mps=.eps}
${document}.ps:		${_MPOST_LIST.${figure:T}:.mps=.eps}
${document}.pdf:	${_MPOST_LIST.${figure:T}:.mps=.pdf}
.endfor
.endfor

.endif # !target(__<texmf.depend.mk>__)

### End of file `texmf.depend.mk'
