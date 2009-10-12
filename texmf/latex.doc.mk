### latex.doc.mk -- Produce LaTeX documents

# Author: Michaël Le Barbier Grünewald
# Date: Dim  9 sep 2007 14:49:18 CEST
# Lang: fr_FR.ISO8859-15

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
# 
# Copyright (C) Michaël Le Barbier Grünewald - 2006-2009
# 
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

# Confer `tex.doc.mk'.

TEX = pdflatex
TEX.dvi = latex
TEX.pdf = pdflatex

MULTIPASS+= aux toc
_TEX_AUX_SUFFIXES?= .log .aux .toc

.include "tex.doc.mk"
.include "latex.bibtex.mk"

_latex_doc_summary: .USE
	${INFO} 'Information summary for ${.TARGET:T}'
	@- (\
	  ! ${GREP} 'LaTeX \(Error\|Warning\|Font Error\)' ${.TARGET:R}.log \
	) && ${ECHO} 'Everything seems in order'

.for var in _TEX_DVI _TEX_PDF _TEX_PS
.if defined(${var})&&!empty(${var})
.for doc in ${${var}}
${doc}: _latex_doc_summary
.endfor
.endif
.endfor

### End of file `latex.doc.mk'
