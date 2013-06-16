### tex.device.dvi.mk -- Réclame la production de fichiers DVI

# Author: Michael Grünewald
# Date: Dim  9 sep 2007 14:49:18 CEST

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

# Ce module analyse les paramètres reçus de tex.texdoc.mk et passe
# commande à tex.driver.dvi.mk pour la production des fichiers DVI
# recquis par ces paramètres.


#
# Commande la création de ${doc}.dvi
#

.for doc in ${_TEX_DOC}
_TEX_DVI+= ${doc}.dvi
.endfor


#
# Spécialisation des variables
#

.for doc in ${_TEX_DOC}
.for var in ${_TEX_VARS}
.if defined(${var}.${doc:T})&&!empty(${var}.${doc:T})&&!defined(${var}.${doc:T}.dvi)
${var}.${doc:T}.dvi = ${${var}.${doc:T}}
.endif
.endfor
.endfor


#
# Clean files
#

# Note: si on inverse les deux boucles SFX et DVI, cela ne marche
# plus, le paramètre formel SFX n'est pas remplacé! (DVI en premier,
# SFX en second.) Ceci peut peut-être s'expliquer d'après les règles
# de traitement des boucles for, mais je ne sais pas clarifier ce
# comportement.

.if !empty(TEXDEVICE:Mdvi)
.for sfx in ${_TEX_AUX_SUFFIXES}
.for dvi in ${_TEX_DVI}
.if empty(CLEANFILES:M${dvi})
CLEANFILES+= ${dvi}
.endif
.for itm in ${dvi:.dvi=${sfx}}
.if empty(CLEANFILES:M${itm})
CLEANFILES+= ${itm}
.endif
.endfor
.endfor
.endfor
.endif


#
# Build and install files
#

.if !empty(TEXDEVICE:Mdvi)
TEXDOC+= ${_TEX_DOC:=.dvi}
.for doc in ${_TEX_DOC}
.if defined(TEXDOCNAME.${doc:T})&&!empty(TEXDOCNAME.${doc:T})
TEXDOCNAME.${doc:T}.dvi = ${TEXDOCNAME.${doc:T}}.dvi
.endif
.endfor
.endif

### End of file `tex.device.dvi.mk'
