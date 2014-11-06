### tex.files.main.mk -- Installation de fichiers pour un système TeX

# Author: Michael Grünewald
# Date: Dim  9 sep 2007 17:32:25 CEST

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

### SYNOPSIS

# TEXFILES+= lmodern.sty
# TEXFILES+= ts1lmvtt.fd
# ...
# FORMAT = latex
# PACKAGE = lm
# TEXDIR = ${TEXMFDIR}/tex/${FORMAT}${PACKAGEDIR}
#
# .include "tex.files.ml"


### DESCRIPTION

# Ce module se charge de l'installation de fichiers de macros dans un
# système TeX. La liste des fichiers à installer doit être émumérée
# dans TEXFILES. Le répertoire de destination est calculé à partir de
# la valeur des variables PACKAGE et FORMAT.
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

# PACKAGE (misc)
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
