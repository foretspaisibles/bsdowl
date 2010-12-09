### noweb.latex.mk -- Préparation de macros LaTeX avec NOWEB

# Author: Michaël Le Barbier Grünewald
# Date: Sam  3 oct 2009 19:10:53 CEST
# Lang: fr_FR.ISO8859-15

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
# 
# Copyright (C) Michaël Le Barbier Grünewald - 2009
# 
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

.include "bps.init.mk"
.include "tex.init.mk"

NOWEAVE_AUTODEFS = tex
NOWEAVE_LATEX_WRAPPER = delay

NOWEAVE_LATEX_DEFS?= ${_BPS_TEXMFDIR}/tex/latex${_BPS_APPLICATIONDIR}/nwlatex.tex
NOWEAVE_HTML_CSS?= nwlatex.css

nwlatex.css: ${_BPS_DATADIR}/nwlatex.css
	${CP} ${.ALLSRC} ${.TARGET}

CLEANFILES+= nwlatex.css
DOCUMENT+= nwlatex.css

_TEX_DOC = ${NOWEAVE}
_TEX_DOC+= sampleart

SRCS.sampleart = ${NOTANGLE} sharticle.cls sampleart.tex

FORMAT = latex
DOCUMENT+= ${NOWEAVE:=.html}

TEXFILES+= ${NOTANGLE}

.include "noweb.main.mk"
.include "bps.project.mk"
.include "tex.files.main.mk"
.include "latex.doc.pre.mk"
.include "tex.init.mk"
.include "tex.mpost.mk"
.include "tex.doc.main.mk"
.include "latex.bibtex.mk"
.include "latex.doc.post.mk"
.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"
