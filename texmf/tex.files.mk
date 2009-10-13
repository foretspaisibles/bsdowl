### tex.files.main.mk -- Installation de fichiers pour un système TeX

# Author: Michaël Le Barbier Grünewald
# Date: Dim  9 sep 2007 17:32:25 CEST
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

# TEXFILES+= lmodern.sty
# TEXFILES+= ts1lmvtt.fd
# ...
# FORMAT = latex
# APPLICATION = lm
# TEXDIR = ${TEXMFDIR}/tex/${FORMAT}${APPLICATIONDIR}
#
# .include "tex.files.ml"


### DESCRIPTION

# Ce module se charge de l'installation de fichiers de macros dans un
# système TeX. La liste des fichiers à installer doit être émumérée
# dans TEXFILES. Le répertoire de destination est calculé à partir de
# la valeur des variables APPLICATION et FORMAT.
#
# Le module réclame la mise-à-jour des bases de données `ls-R'
# nécessaires.

#
# Description des variables
#

# TEXFILES
#
#  Énumère les fichiers de macros à installer

# FORMAT (generic)
#
#  Format pour lequel les macros sont écrites
#
#  Les valeurs courantes sont: amstex, context, generic, latex, plain.
#  Ce nom est utilisé pour calculer le dossier d'installation
#  TEXFILESDIR.

# APPLICATION (misc)
#
#  Application désignant les macros
#
#  Ce nom est utilisé pour calculer le dossier d'installation
#  TEXFILESDIR.

# MKTEXLSR (mktexlsr)
#
#  Programme utilisé pour mettre à jour la base de données `ls-R'

### IMPLÉMENTATION

.include "bps.init.mk"
.include "texmf.init.mk"
.include "tex.files.main.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `tex.files.main.mk'
