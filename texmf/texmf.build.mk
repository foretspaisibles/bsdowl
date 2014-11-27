### texmf.build.mk -- Build rules for TeX documents

# Author: Michael Grünewald
# Date: Mon Nov 24 14:03:50 CET 2014

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

.if !target(__<texmf.build.mk>__)
__<texmf.build.mk>__:

.for document in ${_TEX_DOCUMENT}
.if defined(SRCS)
SRCS.${document:T}+=	${SRCS}
.endif
.if exists(${document:T}.tex)&&empty(SRCS.${document:T}:M${document:T}.tex)
SRCS.${document:T}+=	${document:T}.tex
.endif
.endfor

.for document in ${_TEX_DOCUMENT}
.for device in ${TEXDEVICE}
DOC+=			${document}.${device}
.endfor
.endfor

.for document in ${_TEX_DOCUMENT}
.for figure in ${SRCS.${document:T}:M*.mp:.mp=}
.if !empty(TEXDEVICE:Mdvi)
DOC+=			${_MPOST_LIST.${figure:T}:.mps=.eps}
.endif
.endfor
.endfor

.for document in ${_MPOST_DOCUMENT}
.if defined(SRCS)
SRCS.${document:T}+=	${SRCS}
.endif
.if exists(${document:T}.mp)&&empty(SRCS.${document:T}:M${document:T}.mp)
SRCS.${document:T}+=	${document:T}.mp
.endif
.endfor

.for document in ${_MPOST_DOCUMENT}
.for device in ${MPDEVICE}
DOC+=			${_MPOST_LIST.${document:T}:.mps=.${device}}
.endfor
.endfor

_TEX_BUILD_TOOL.dvi=	${_TEX_TOOL.tex}
_TEX_BUILD_FIGURE.dvi=	eps

_TEX_BUILD_TOOL.pdf=	${_TEX_TOOL.pdftex}
_TEX_BUILD_FIGURE.pdf=	pdf

.for device in dvi pdf
.tex.${device}:
.if defined(MULTIPASS)&&!empty(MULTIPASS)&&(${DRAFT} == no)
.for pass in ${MULTIPASS}
	${INFO} 'Multipass job for ${.TARGET} (${pass})'
	${_TEX_BUILD_TOOL.${device}} ${.IMPSRC}
.endfor
.else
	${_TEX_BUILD_TOOL.${device}} ${.IMPSRC}
.endif
.if defined(_TEX_VALIDATE)
	${_TEX_VALIDATE}
.endif
.endfor


.dvi.ps:
	${DVIPS} -o ${.TARGET} ${.IMPSRC}

.if defined(_TEX_PRINTER)
.for printer in ${_TEX_PRINTER}
.dvi.${printer}.ps:
	${DVIPS} -P ${printer} -o ${.TARGET} ${.IMPSRC}
.endfor
.endif

.mps.png:
	${MP2PNG} -o ${.TARGET} ${.IMPSRC}

.mps.eps:
	${MP2EPS} -o ${.TARGET} ${.IMPSRC}

.eps.pdf:
	${EPSTOPDF} --outfile=${.TARGET} ${.IMPSRC}


#
# Specific rules to generate DVI files
#

.if defined(MULTIPASS)&&!empty(MULTIPASS)&&(${DRAFT} == no)
.for device in dvi pdf
.for document in ${_TEX_DOCUMENT}
.undef pass_last
.for pass in ${MULTIPASS}
.if undefined(pass_last)||empty(pass_last)
.for figure in ${SRCS.${document:T}:M*.mp:.mp=}
${COOKIEPREFIX}${document:T}.${device}.${pass}:\
	  ${_MPOST_LIST.${figure:T}:.mps=.${_TEX_BUILD_FIGURE.${device}}}
.endfor
${COOKIEPREFIX}${document:T}.${device}.${pass}: ${SRCS.${document:T}}
.else
${COOKIEPREFIX}${document:T}.${device}.${pass}:  ${SRCS.${document:T}}\
	  ${COOKIEPREFIX}${document:T}.${device}.${pass_last}
.endif
	${INFO} 'Multipass job for ${document:T}.${device} (${pass})'
	${_TEX_BUILD_TOOL.${device}} ${.ALLSRC:M*${document:T}.tex}
	@${TOUCH} -d 1971-01-01T01:00:00 ${document}.${device}
	@${TOUCH} ${.TARGET}

pass_last:=		${pass}
.endfor
${document}.${device}:	${SRCS.${document:T}}\
	  ${COOKIEPREFIX}${document:T}.${device}.${pass_last}
	${INFO} 'Multipass job for ${document:T}.${device} (final)'
	${_TEX_BUILD_TOOL.${device}} ${.ALLSRC:M*${document:T}.tex}
.if defined(_TEX_VALIDATE)
	${_TEX_VALIDATE}
.endif
.endfor
.endfor
.endif


#
# Register cookiefiles
#

.if defined(MULTIPASS)&&!empty(MULTIPASS)&&(${DRAFT} == no)
.for document in ${_TEX_DOCUMENT}
.for pass in ${MULTIPASS}
COOKIEFILES+=		${COOKIEPREFIX}${document:T}.dvi.${pass}
COOKIEFILES+=		${COOKIEPREFIX}${document:T}.pdf.${pass}
.endfor
.endfor
.endif

.endif # !target(__<texmf.build.mk>__)

### End of file `texmf.build.mk'
