### latex.files.mk -- Installation de fichiers pour un système LaTeX

# Author: Michaël Le Barbier Grünewald
# Date: Dim  9 sep 2007 17:52:28 CEST
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

### SYNOPSIS

# LATEX+= lmodern.sty
# LATEX+= ts1lmvtt.fd
# ...
# APPLICATION = lm
# LATEXDIR = ${TEXMFDIR}/tex/latex${APPLICATIONDIR}
#
# .include "tex.files.ml"

# Le fragment précédent s'arrange pour que `build' dépende des
# fichiers figurant dans la liste LATEX et pour que `install' installe
# ces fichiers dans ${LATEXDIR}.


TEXGROUP = LATEX
FORMAT = latex

.include "tex.files.mk"

### End of file `latex.files.mk'
