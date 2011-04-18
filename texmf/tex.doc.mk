### tex.doc.mk -- Produce TeX documents

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

### SYNOPSIS
# APPLICATION = Cours/2de
#
# DOCS = lalala
# DOCS+= lalali.tex
#
# SRCS = macro.mac
# SRCS.lalala = extra.tex
# SRCS.lalali = title.tex headline.tex footline.tex
#
# TEXDEVICE = dvi pdf ps
# FORMAT.dvi =
# FORMAT.pdf =
# FORMAT.ps =
# FORMAT.dvi.lalala = ...
#
# INTERACTION = batch nonstop scroll errorstop
# JOBNAME
#
# Instance variables:
# TEXINPUTS, TEXMFOUTPUT, FORMATS, TEXPOOL, TFMFONTS
# conflit puisque pour produire un fichier PostScript, le fichier DVI
# est une étape intermédiaire.
#
# Pour produire un fichier DVI qui est un intermédiaire pour DEVICE,
# on ajoute donc DEVICE à la fin de JOBNAME pour l'éxécution.

.include "tex.doc.pre.mk"
.include "tex.doc.main.mk"

### End of file `tex.doc.mk'
