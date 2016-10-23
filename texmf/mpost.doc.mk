### mpost.doc.mk -- Prepare pictures with METAPOST

# Author: Michael Grünewald
# Date: Wed Nov 26 19:21:34 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

# PACKAGE=		linalg
# MPDEVICE=		eps svg pdf
#
# DOCUMENT=		figure1
# DOCUMENT+=		figure2
# DOCUMENT+=		figure3
#
# SRCS=			macro.mp
# SRCS.figure2=		macro2.mp


# Variables:
#
#  MPDEVICE [eps]
#   The METAPOST backend that should be used to produce documents
#
#   Several backends can be simultaneously used. Available backends
#   are eps, svg and pdf.
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
#  MPINPUTS [not set]
#   The list of directories where METAPOST input files are looked up

THISMODULE=		mpost.doc

.if !defined(DOCUMENT)||empty(DOCUMENT)
.error The mpost.doc.mk module expects you to set the DOCUMENT\
	  variable to a sensible value.
.endif

MPDEVICE?=		eps
_MPOST_DOCUMENT=	${DOCUMENT:.mp=}
_PACKAGE_CANDIDATE=	${_MPOST_DOCUMENT}
PRODUCT=		${DOC}

.include "texmf.init.mk"
.include "texmf.build.mk"
.include "texmf.mpost.mk"
.include "texmf.depend.mk"
.include "texmf.clean.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

### End of file `mpost.doc.mk'
