### latex.doc.pre.mk -- Produce LaTeX documents

# Author: Michael Grünewald
# Date: Dim  9 sep 2007 14:49:18 CEST

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

TEX = pdflatex
TEX.dvi = latex
TEX.pdf = pdflatex

MULTIPASS+= aux toc
_TEX_AUX_SUFFIXES?= .log .aux .toc .out
_TEX_SUFFIXES?= .tex .latex .cls .sty

MPOST_CONVERT_MPS?= no

### End of file `latex.doc.pre.mk'
