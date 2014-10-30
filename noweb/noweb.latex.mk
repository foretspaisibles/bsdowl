### noweb.latex.mk -- Préparation de macros LaTeX avec NOWEB

# Author: Michael Grünewald
# Date: Sam  3 oct 2009 19:10:53 CEST

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

.include "bps.init.mk"

NOWEAVE_GROUP?= DOC
NOWEAVE_AUTODEFS = tex
NOWEAVE_LATEX_WRAPPER = delay

NOWEAVE_LATEX_DEFS?= ${_BPS_TEXMFDIR}/tex/latex${_BPS_PACKAGEDIR}/nwlatex.tex

FORMAT = latex

#
# TEXFILES
#

# The group TEXFILES holds the files produced by NOTANGLE.

FILESGROUPS+= TEXFILES

TEXFILESOWN?= ${SHAREOWN}
TEXFILESGRP?= ${SHAREGRP}
TEXFILESMODE?= ${SHAREMODE}
TEXFILESDIR?= ${PREFIX}/share/texmf/latex${PACKAGEDIR}

TEXFILES+= ${NOTANGLE}

TEXDOCDIR?= ${PREFIX}/share/texmf/doc/latex${PACKAGEDIR}

#
# Stylesheet
#

NOWEAVE_HTML_CSS?= nwlatex.css
CLEANFILES+= nwlatex.css
${NOWEAVE_GROUP}+= nwlatex.css

nwlatex.css: ${_BPS_DATADIR}/nwlatex.css
	${CP} ${.ALLSRC} ${.TARGET}

.include "noweb.main.mk"
# .include "tex.files.main.mk"
# .include "tex.mpost.mk"
# .include "tex.doc.main.mk"
# .include "latex.bibtex.mk"
# .include "latex.doc.post.mk"
# .include "bps.clean.mk"
# .include "bps.files.mk"
# .include "bps.usertarget.mk"
# .include "bps.project.mk"
.include "latex.doc.mk"
.include "bps.usertarget.mk"
.include "bps.project.mk"
