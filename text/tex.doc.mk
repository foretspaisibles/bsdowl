### tex.doc.mk -- Produce TeX documents

# Author: Michaël Le Barbier Grünewald
# Date: Dim  9 sep 2007 14:49:18 CEST
# Lang: fr_FR.ISO8859-15

# $Id$

# Copyright (c) 2006, 2007, 2008, 2009 Michaël Le Barbier Grünewald
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#    1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#    2. Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#
#    3. The name of the author may not be used to endorse or promote
#    products derived from this software without specific prior written
#    permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

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

.include "tex.init.mk"
.include "bps.init.mk"
.include "tex.mpost.mk"
.include "tex.doc.main.mk"
.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `tex.doc.mk'
