### tex.doc.mk -- Produce TeX documents

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

### SYNOPSIS

# PACKAGE=		linalg
# TEXDEVICE=		dvi pdf ps
#
# DOCUMENT=		lecture1
# DOCUMENT+=		lecture2
# DOCUMENT+=		lecture3
#
# SRCS=			macro.mac
# SRCS.lecture2=	figure.mp


# Variables:
#
#  TEXDEVICE [pdf]
#   The TeX backend that should be used to produce documents
#
#
#  DOCUMENT [not set]
#   The list of documents to be produced
#
#
#  SRCS [not set]
#   The sources used to produce our document
#
#   This list can contain macro files, TeX files and Metapost files.
#
#
#  JOBNAME [not set]
#   The jobname passed to TeX
#
#
#  INTERACTION [not set]
#   The TeX interaction mode
#
#   It can be one of batch, nonstop, scroll or errorstop.
#
#
#  TEXINPUTS [not set]
#   The list of directories where TeX input files are looked up
#
#
#  TEXMFOUTPUT [${.OBJDIR} if it differs from ${.CURDIR}]
#   The directory where TeX should write its output
#
#
#  TEXFORMATS, TEXPOOL, TFMFONTS [not set]
#   Variables transferred to TeX environment

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
${_MPOST_LIST.${figure:T}}: ${figure}
	${_MPOST_TOOL} ${.ALLSRC}
.if !empty(TEXDEVICE:Mdvi)
DOC+=			${_MPOST_LIST.${figure:T}:.mps=.eps}
.endif
.endfor
.endfor

.include "texmf.build.mk"
.include "texmf.depend.mk"
.include "texmf.clean.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

### End of file `tex.doc.mk'
