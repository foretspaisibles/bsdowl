### latex.doc.mk -- Produce LaTeX documents

# Author: Michael Grünewald
# Date: Dim Sep  9 2007 14:49:18 CEST

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

# Confer `tex.doc.mk'.

THISMODULE=		tex.doc

.if !defined(DOCUMENT)||empty(DOCUMENT)
.error The tex.doc.mk module expects you to set the DOCUMENT\
	  variable to a sensible value.
.endif

TEXDEVICE?=		pdf
_PACKAGE_CANDIDATE=	${DOCUMENT}

.for device in ${TEXDEVICE}
PRODUCT+=		${DOCUMENT:C@$@.${device}@}
.endfor

TEX=			pdflatex
TEX.tex=		latex
TEX.pdftex=		pdflatex

MULTIPASS+=		aux toc
_TEX_AUX_SUFFIXES?=	.log .aux .toc .out
_TEX_SUFFIXES?=		.tex .latex .cls .sty

_TEX_VALIDATE=\
	${INFO} 'Information summary for ${.TARGET:T}';\
	(test -f ${.TARGET:R}.log &&\
	  ! ${GREP} 'LaTeX \(Error\|Warning\|Font Error\)' ${.TARGET:R}.log\
	) && ${ECHO} 'Everything seems in order'

.include "texmf.init.mk"

.for document in ${DOCUMENT}
.if defined(SRCS)
SRCS.${document:T}+=	${SRCS}
.endif
.if exists(${document:T}.tex)&&empty(SRCS.${document:T}:M${document:T}.tex)
SRCS.${document:T}+=	${document:T}.tex
.endif
.endfor

.for document in ${DOCUMENT}
.for device in ${TEXDEVICE}
DOC+=			${document}.${device}
.endfor
.endfor

.for document in ${DOCUMENT}
.for figure in ${SRCS.${document:T}:M*.mp}
.if !empty(TEXDEVICE:Mdvi)
DOC+=			${_MPOST_LIST.${figure:T}:.mps=.eps}
.endif
.endfor
.endfor

.include "texmf.build.mk"
.include "texmf.mpost.mk"
.include "texmf.depend.mk"
.include "texmf.clean.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

### End of file `latex.doc.mk'
