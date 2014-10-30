### tex.init.mk -- Service d'initialisation

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

.if !target(__<tex.init.mk>__)
__<tex.init.mk>__:

.include "texmf.init.mk"

DRAFT?= no

TEXTIMESTAMP!= date '+%Y-%m-%d'

.if ${DRAFT} == no
.undef TEXDRAFTSTAMP
.else
TEXDRAFTSTAMP?= -${TEXTIMESTAMP}
.endif

TEXDEVICE?= dvi
TEX?= pdftex
TEX.dvi?= tex
TEX.pdf?= pdftex
TEX.ps?= ${TEX.dvi}

# Les variables énumérées par _TEX_VARS sont des variables d'instance
# supportant une spécialisation pour chaque cible.
_TEX_VARS+= TEXINPUTS TEXMFOUTPUT TEXFORMATS TEXPOOL TFMFONTS
_TEX_VARS+= INTERACTION JOBNAME TEXFORMATS
_TEX_VARS+= COMMENT PROGNAME

_TEX_DOC?= ${DOCS:.tex=}

_TEX_DEVICES?= pdf ps dvi

_TEX_SUFFIX.dvi = .dvi
_TEX_SUFFIX.pdf = .pdf
_TEX_SUFFIX.ps = .ps

_TEX_DRIVER.dvi?= dvi
_TEX_DRIVER.pdf?= pdftex
_TEX_DRIVER.ps?= dvips


# Fichiers source de TeX
_TEX_SUFFIXES?= .tex
_TEX_AUX_SUFFIXES?= .log

.for device in ${_TEX_DEVICES}
_TEX_DRIVERS+= ${_TEX_DRIVER.${device}}
.endfor

# Utilisation de MASTERDIR
.if defined(MASTERDIR)&&!empty(MASTERDIR)
TEXINPUTS+= ${MASTERDIR}
MPINPUTS+= ${MASTERDIR}
BIBINPUTS+= ${MASTERDIR}
.PATH: ${MASTERDIR}
.endif

# Si la variable TEXINPUTS est définie, on utilise sa valeur pour
# .PATH.tex, etc. De même avec MPTEXINPUTS.

.SUFFIXES: ${_TEX_SUFFIXES}
.if defined(TEXINPUTS)&&!empty(TEXINPUTS)
.for suffix in ${_TEX_SUFFIXES}
.PATH${suffix}: ${TEXINPUTS}
.endfor
.endif
.if defined(MPTEXINPUTS)&&!empty(MPTEXINPUTS)
.for suffix in ${_TEX_SUFFIXES}
.PATH${suffix}: ${MPTEXINPUTS}
.endfor
.endif

# Get rid of the file missfont.log, if it is present.

.if exists(missfont.log)
DISTCLEANFILES+= missfont.log
.endif

.endif #!target(__<tex.init.mk>__)

### End of file `tex.init.mk'
