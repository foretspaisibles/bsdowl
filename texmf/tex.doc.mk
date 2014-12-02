### tex.doc.mk -- Produce TeX documents

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
#  TEXINPUTS [not set]
#   The list of directories where TeX input files are looked up
#
#
#  MPTEXINPUTS [${TEXINPUTS}]
#   Same as TEXINPUTS when TeX is run in a METAPOST job
#
#
#  TEXMFOUTPUT [${.OBJDIR} if it differs from ${.CURDIR}]
#   The directory where TeX should write its output
#
#
#  TEXFORMATS, TEXPOOL, TFMFONTS [not set]
#   Variables transferred to TeX environment
#
#
# Uses:
#
#  texinputs:strict
#   Do not add . and texmf to TeX search path
#
#   This setting affect both TEXINPUTS and MPTEXINPUTS.
#
#
#  mpinputs:strict
#   Do not add . and texmf to METAPOST search path
#
#
#  texinteraction: one of batch, nonstop, scroll or errorstop.
#   Change TeX interaction mode
#
#
#  draft: at most one of time, git, svn, cvs, auto
#   Select a strategy for draft stamps


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

.include "texmf.init.mk"

.include "texmf.build.mk"
.include "texmf.mpost.mk"
.include "texmf.depend.mk"
.include "texmf.clean.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

### End of file `tex.doc.mk'
