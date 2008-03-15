### tex.mpost.mk -- Création de figures avec METAPOST

# Author: Michaël Grünewald
# Date: Dim  9 sep 2007 14:49:18 CEST
# Lang: fr_FR.ISO8859-15

# $Id$

# Copyright (c) 2006, 2007, 2008, Michaël Grünewald
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

# FIGS = conics.mp
# FIGS+= desargues.mp
#
# FIGS.lalala = pappus.mp
#
# .include "tex.mpost.mk"

#
# Pseudo-outils
#

MPOST?= mpost
MP2EPS?= mp2eps
MP2PDF?= mp2pdf
MP2PNG?= mp2png

MPOST_DEVICE.dvi?= eps
MPOST_DEVICE.ps?= eps
MPOST_DEVICE.pdf?= pdf

_MP_VARS+= MPINPUTS
_MP_VARS+= MPTEX

.if !empty(TEXDEVICE:M*.ps)
.for device in ${TEXDEVICE:M*.ps}
MPOST_DEVICE.${device} = ${MPOST_DEVICE.ps}
.endfor
.endif

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
_MPOST_LIST.${fig:T}!= sed -n 's/^beginfig(\([0-9][0-9]*\)).*/${fig:.mp=}.\1/p' ${fig}
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
SRCS.${doc:T}.${device}+= ${_MPOST_LIST.${fig:T}:=.${MPOST_DEVICE.${device}}}
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

.for var in ${_TEX_VARS} ${_MP_VARS}
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
_MPOST_ENV.${fig:T}+= MPINPUTS=${MPINPUTS.${fig:T}:Q:S/\\ /:/g}
.endif
.if defined(TEXINPUTS.${fig:T})&&!empty(TEXINPUTS.${fig:T})
_MPOST_ENV.${fig:T}+= TEXINPUTS=${TEXINPUTS.${fig:T}:Q:S/\\ /:/g}
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
# On ajoute le fichier source
_MPOST_BUILD.${fig:T}+= ${fig}
.endfor


#
# Traitement des fichiers par METAPOST
#

.for fig in ${_MPOST_FIG}
${_MPOST_LIST.${fig:T}}: ${fig}
	${_MPOST_BUILD.${fig:T}} ${.ALLSRC}
.endfor

#
# Traitement ultérieur des fichiers
#

.for fig in ${_MPOST_FIG}
.for device in ${TEXDEVICE}
.for item in ${_MPOST_LIST.${fig:T}}
${item}.${MPOST_DEVICE.${device}}: ${item}
	${MPOST_TOOL.${MPOST_DEVICE.${device}}} ${.ALLSRC}
.endfor
.endfor
.endfor

#
# Cleanfiles
#

.for fig in ${_MPOST_FIG}
CLEANFILES+= ${fig:.mp=.log} ${fig:.mp=.mpx} ${_MPOST_LIST.${fig:T}}
.endfor

.for fig in ${_MPOST_FIG}
.for device in ${TEXDEVICE}
.for item in ${_MPOST_LIST.${fig:T}}
CLEANFILES+= ${item}.${MPOST_DEVICE.${device}}
.endfor
.endfor
.endfor

.for file in mpxerr.log mpxerr.tex
.if exists(${file})
CLEANFILES+= ${file}
.endif
.endfor

### End of file `tex.mpost.mk'
