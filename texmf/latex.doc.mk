### latex.doc.mk -- Produce LaTeX documents

# Author: Michael Grünewald
# Date: Sun Sep  9 14:49:18 CEST 2007

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
_TEX_DOCUMENT=		${DOCUMENT:.tex=}
_PACKAGE_CANDIDATE=	${_TEX_DOCUMENT}

.for device in ${TEXDEVICE}
PRODUCT+=		${_TEX_DOCUMENT:=.${device}}
.endfor

TEX=			pdflatex
TEX.tex=		latex
TEX.pdftex=		pdflatex

MULTIPASS+=		aux toc
_TEX_AUX_SUFFIXES?=	.log .aux .toc .out
_TEX_SUFFIXES?=		.tex .latex .cls .sty

.include "texmf.init.mk"

_TEX_VALIDATE=\
	${INFO} 'Information summary for ${.TARGET:T}' &&\
	(test -f ${.TARGET:R}.log &&\
	  ! ${GREP} 'LaTeX \(Error\|Warning\|Font Error\)' ${.TARGET:R}.log\
	) && ${ECHO} 'Everything seems in order'

.include "texmf.build.mk"
.include "texmf.bibtex.mk"
.include "texmf.index.mk"
.include "texmf.mpost.mk"
.include "texmf.depend.mk"
.include "texmf.clean.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

### End of file `latex.doc.mk'
