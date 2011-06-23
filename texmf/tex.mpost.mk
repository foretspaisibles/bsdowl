### tex.mpost.mk -- Création de figures avec METAPOST

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

# FIGS = conics.mp
# FIGS+= desargues.mp
#
# FIGS.lalala = pappus.mp
#
# .include "tex.mpost.mk"

#
# Description
#

# MPTEXINPUTS
#
#  This special variable shadows TEXINPUTS when it is defined, this will ease
#  the share of figure files across several files. Note that, in this case,
#  figures should be put in a separate folder.

# MPOST_TRANSLATE_NAMES (no)
#
#  Controls translation of picture names
#
#  Some macro packages do not work well with METAPOST picture names,
#  ending aith a dot followed by a number.  If the falg is set to yes,
#  we replace this final dot with a hyphen and add a `.mps' suffix.

#
# Pseudo-outils
#

MPOST?= mpost
MPTEX?= ${TEX.dvi}
MP2EPS?= mp2eps
MP2PDF?= mp2pdf
MP2PNG?= mp2png

MPOST_TRANSLATE_NAMES?= no

MPOST_DEVICE.dvi?= eps
MPOST_DEVICE.ps?= eps
MPOST_DEVICE.pdf?= pdf

.if !empty(TEXDEVICE:M*.ps)
.for device in ${TEXDEVICE:M*.ps}
MPOST_DEVICE.${device} = ${MPOST_DEVICE.ps}
.endfor
.endif

_MPOST_CLEAN?=

_MPOST_FIG?=
_MPOST_VARS+= MPINPUTS
_MPOST_VARS+= MPTEX
_MPOST_VARS+= MPTEXINPUTS

MPOST_TOOL.eps = ${MP2EPS}
MPOST_TOOL.pdf = ${MP2PDF}
MPOST_TOOL.png = ${MP2PNG}

#
# Analyse des fichiers de figures
#

.for fig in ${FIGS}
.if empty(_MPOST_FIG:M${fig})
_MPOST_FIG+=${fig}
.endif
.endfor

.for doc in ${_TEX_DOC}
.if defined(FIGS.${doc:T})&&!empty(FIGS.${doc:T})
.for fig in ${FIGS.${doc:T}}
.if empty(_MPOST_FIG:M${fig})
_MPOST_FIG+=${fig}
.endif
.endfor
.endif
.endfor

.for fig in ${_MPOST_FIG}
${COOKIEPREFIX}${fig:T}: ${fig}
.if ${MPOST_TRANSLATE_NAMES} == "no"
	@${SED} -n 's/^beginfig(\([0-9][0-9]*\)).*/${fig:.mp=}.\1/p' ${.ALLSRC} > ${.TARGET}
.else
	@${SED} -n 's/^beginfig(\([0-9][0-9]*\)).*/${fig:.mp=}-\1.mps/p' ${.ALLSRC} > ${.TARGET}
.endif
depend: ${COOKIEPREFIX}${fig:T}
.if exists(${COOKIEPREFIX}${fig:T})
_MPOST_LIST.${fig:T}!= cat ${COOKIEPREFIX}${fig:T}
.else
_MPOST_LIST.${fig:T} =
.endif
HARDCOOKIEFILES+= ${COOKIEPREFIX}${fig:T}
.endfor

#
# Ajout des sources
#

.if defined(_TEX_DOC)&&!empty(_TEX_DOC)
.for doc in ${_TEX_DOC}

.if defined(FIGS)&&!empty(FIGS)
FIGS.${doc:T}+= ${FIGS}
.endif

.if defined(FIGS.${doc:T})
.for fig in ${FIGS.${doc:T}}
.for device in ${TEXDEVICE}
.if ${MPOST_TRANSLATE_NAMES} == "yes"
SRCS.${doc:T}.${device}+= ${_MPOST_LIST.${fig:T}:.mps=.${MPOST_DEVICE.${device}}}
.else
SRCS.${doc:T}.${device}+= ${_MPOST_LIST.${fig:T}:=.${MPOST_DEVICE.${device}}}
.endif
.endfor
.endfor
.endif

.endfor
.endif

#
# Création des lignes de commande pour METAPOST
#

# Les fichiers METAPOST peuvent contenir des commandes TeX. Ils
# doivent donc être éxécutés dans le même environnement que si le
# fichier devait être traité par TeX.
#
# On passe donc les variables TEXINPUTS, TEXFORMATS, etc. dans
# l'environnement du programme METAPOST.

.for var in ${_TEX_VARS} ${_MPOST_VARS}
.for fig in ${FIGS}
.if defined(${var})&&!empty(${var})&&!defined(${var}.${fig:T})
${var}.${fig:T} = ${${var}}
.endif
.endfor
.endfor

.for fig in ${FIGS}
.if defined(MPTEX.${fig:T})&&!empty(MPTEX.${fig:T})
_MPOST_ENV.${fig:T}+= TEX=${MPTEX.${fig:T}:Q}
.endif
.if defined(MPINPUTS.${fig:T})&&!empty(MPINPUTS.${fig:T})
.if !defined(USE_STRICT_MPINPUTS)|| ${USE_STRICT_MPINPUTS} != yes
_MPOST_ENV.${fig:T}+= MPINPUTS=".:${MPINPUTS.${fig:T}:Q:S/\\ /:/g}:"
.else
_MPOST_ENV.${fig:T}+= MPINPUTS="${MPINPUTS.${fig:T}:Q:S/\\ /:/g}"
.endif
.endif
.if defined(MPTEXINPUTS.${fig:T})&&!empty(MPTEXINPUTS.${fig:T})
.if !defined(USE_STRICT_MPTEXINPUTS)|| ${USE_STRICT_MPTEXINPUTS} != yes
_MPOST_ENV.${fig:T}+= TEXINPUTS=".:${MPTEXINPUTS.${fig:T}:Q:S/\\ /:/g}:"
.else
_MPOST_ENV.${fig:T}+= TEXINPUTS="${MPTEXINPUTS.${fig:T}:Q:S/\\ /:/g}"
.endif
.elif defined(TEXINPUTS.${fig:T})&&!empty(TEXINPUTS.${fig:T})
.if !defined(USE_STRICT_TEXINPUTS)|| ${USE_STRICT_TEXINPUTS} != yes
_MPOST_ENV.${fig:T}+= TEXINPUTS=".:${TEXINPUTS.${fig:T}:Q:S/\\ /:/g}:"
.else
_MPOST_ENV.${fig:T}+= TEXINPUTS="${TEXINPUTS.${fig:T}:Q:S/\\ /:/g}"
.endif
.endif
.if defined(TEXMFOUTPUT.${fig:T})&&!empty(TEXMFOUTPUT.${fig:T})
_MPOST_ENV.${fig:T}+= TEXMFOUTPUT=${TEXMFOUTPUT.${fig:T}:Q}
.endif
.if defined(TEXFORMATS.${fig:T})&&!empty(TEXFORMATS.${fig:T})
_MPOST_ENV.${fig:T}+= TEXFORMATS=${TEXFORMATS.${fig:T}:Q}
.endif
.if defined(TEXPOOL.${fig:T})&&!empty(TEXPOOL.${fig:T})
_MPOST_ENV.${fig:T}+= TEXPOOL=${TEXPOOL.${fig:T}:q}
.endif
.if defined(TFMFONTS.${fig:T})&&!empty(TFMFONTS.${fig:T})
_MPOST_ENV.${fig:T}+= TFMFONTS=${TFMFONTS.${fig:T}:Q}
.endif
# On tient compte de l'environnement pour construire la ligne de commande
.if defined(_MPOST_ENV.${fig:T})&&!empty(_MPOST_ENV.${fig:T})
_MPOST_BUILD.${fig:T} = ${ENVTOOL} ${_MPOST_ENV.${fig:T}} ${MPOST}
.else
_MPOST_BUILD.${fig:T} = ${MPOST}
.endif
.endfor

#
# Chemins de recherche
#

# Si la variable MPINPUTS est définie, on utilise sa valeur pour
# .PATH.mp.

.SUFFIXES: .mp
.if defined(MPINPUTS)&&!empty(MPINPUTS)
.PATH.mp: ${MPINPUTS}
.endif


#
# Traitement des fichiers par METAPOST
#

.for fig in ${_MPOST_FIG}
${_MPOST_LIST.${fig:T}}: ${fig}
	${_MPOST_BUILD.${fig:T}} ${.ALLSRC}
.if ${MPOST_TRANSLATE_NAMES} == "yes"
	for f in ${_MPOST_LIST.${fig:T}}; do\
	  a="$${f%.mps}"; \
	  b="$${a%%-*}"; \
	  c="$${a##*-}"; \
	  mv -f "$$b.$$c" "$$f"; \
	done
.endif
.endfor


#
# Traitement ultérieur des fichiers
#

# Remarque: à cause de la boucle `for device', si plusieurs fichiers
# PostScript sont produits, plusieurs recettes pour les figures EPS
# sont potentiellement générées. On corrige ce comportement (définir
# plusieurs recettes pour produire un ficheir donné est une erreur) en
# testant l'existence d'une recette pour produire le fichier de
# figure avant de proposer la recette générée automatiquement dans la
# boucle.

.for fig in ${_MPOST_FIG}
.for device in ${TEXDEVICE}
.for item in ${_MPOST_LIST.${fig:T}}
.if ${MPOST_TRANSLATE_NAMES} == "yes"
.if !target(${item:.mps=.${MPOST_DEVICE.${device}}})
${item:.mps=.${MPOST_DEVICE.${device}}}: ${item}
	${MPOST_TOOL.${MPOST_DEVICE.${device}}} ${.ALLSRC}
.endif
.else
.if !target(${item}.${MPOST_DEVICE.${device}})
${item}.${MPOST_DEVICE.${device}}: ${item}
	${MPOST_TOOL.${MPOST_DEVICE.${device}}} ${.ALLSRC}
.endif
.endif
.endfor
.endfor
.endfor


#
# Cleanfiles
#

.for fig in ${_MPOST_FIG}
DISTCLEANFILES+= ${fig:.mp=.log} ${fig:.mp=.mpx} ${_MPOST_LIST.${fig:T}}
.endfor

.for fig in ${_MPOST_FIG}
.for device in ${TEXDEVICE}
.for item in ${_MPOST_LIST.${fig:T}}
.if ${MPOST_TRANSLATE_NAMES} == "yes"
REALCLEANFILES+= ${item:.mps=.${MPOST_DEVICE.${device}}}
.else
REALCLEANFILES+= ${item}.${MPOST_DEVICE.${device}}
.endif
.endfor
.endfor
.endfor

.for file in mpxerr.log mpxerr.tex
.if exists(${file})
CLEANFILES+= ${file}
.endif
.endfor

### End of file `tex.mpost.mk'
