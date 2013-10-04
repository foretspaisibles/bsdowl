### latex.doc.pre.mk -- Produce LaTeX documents

# Author: Michael Grünewald
# Date: Dim  9 sep 2007 14:49:18 CEST
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2006-2009, 2013 Michael Grünewald
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
_TEX_AUX_SUFFIXES?= .log .aux .toc .out
_TEX_SUFFIXES?= .tex .latex .cls .sty

### End of file `latex.doc.pre.mk'
