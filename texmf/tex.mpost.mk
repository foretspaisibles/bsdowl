### tex.mpost.mk -- Création de figures avec METAPOST

# Author: Michael Grünewald
# Date: Dim  9 sep 2007 14:49:18 CEST
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

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

# MPOST_OBJECTS
#
#  List of Metapost objects
#
#  After evaluation of this file, the variable MPOST_OBJECTS contains
#  the list of Metapost intermediary objects.

# MPOST_CONVERT_MPS (yes)
#
#  Control conversion of METAPOST encapsulated PostScript to device
#
#  The program pdfTeX is not able to include directly encapsulated
#  PostScript and therefore require these files to be converted to
#  PDF.  For LaTeX the graphicx package will take care of this
#  conversion but other packages will need support.

# MPOST_LIBS
#
#  Libraries of Metapost macros.


MPOST_CONVERT_MPSTOPDF?= yes

#
# Pseudo commands
#

MPOST?= mpost
MPTEX?= ${TEX.dvi}
MP2EPS?= mp2eps
MP2PDF?= mp2pdf
MP2PNG?= mp2png

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
# Analyse figure files
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

# The variable _MPOST_FIG holds the list of figure files used by the
# document.

.for fig in ${_MPOST_FIG}
${COOKIEPREFIX}${fig:T}: ${fig}
	@${SED} -n 's/^beginfig(\([0-9][0-9]*\)).*/${fig:.mp=}-\1.mps/p' ${.ALLSRC} > ${.TARGET}
depend: ${COOKIEPREFIX}${fig:T}
.if exists(${COOKIEPREFIX}${fig:T})
_MPOST_LIST.${fig:T}!= cat ${COOKIEPREFIX}${fig:T}
.else
_MPOST_LIST.${fig:T} =
.endif
HARDCOOKIEFILES+= ${COOKIEPREFIX}${fig:T}
.endfor

# For each figure file, the variable _MPOST_LIST.${fig:T} holds the
# list of figures---if this list was once generated.


#
# Adding sources
#

.if defined(_TEX_DOC)&&!empty(_TEX_DOC)
.for doc in ${_TEX_DOC}

.if defined(FIGS)&&!empty(FIGS)
FIGS.${doc:T}+= ${FIGS}
.endif

.if defined(FIGS.${doc:T})
.for fig in ${FIGS.${doc:T}}
.for device in ${TEXDEVICE}
.if ${MPOST_CONVERT_MPS} == "yes"
.for item in ${_MPOST_LIST.${fig:T}}
SRCS.${doc:T}.${device}+= ${item:.mps=.${MPOST_DEVICE.${device}}}
.endfor
.else
SRCS.${doc:T}.${device}+= ${_MPOST_LIST.${fig:T}}
.endif
.endfor
.endfor
.endif

.endfor
.endif

#
# Creating command lines
#

# METAPOST files can contain TeX commands.  We therefore have to
# ensure, they are processed in a similar environment.

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
.if defined(_MPOST_ENV.${fig:T})&&!empty(_MPOST_ENV.${fig:T})
_MPOST_BUILD.${fig:T} = ${ENVTOOL} ${_MPOST_ENV.${fig:T}} ${MPOST}
.else
_MPOST_BUILD.${fig:T} = ${MPOST}
.endif
.endfor

#
# Path for file lookup
#

.SUFFIXES: .mp
.if defined(MPINPUTS)&&!empty(MPINPUTS)
.PATH.mp: ${MPINPUTS}
.endif


#
# Processing files
#

.for fig in ${_MPOST_FIG}
${_MPOST_LIST.${fig:T}}: ${fig}
	${_MPOST_BUILD.${fig:T}} ${fig}
.if defined(MPOST_LIBS)&&!empty(MPOST_LIBS)
${_MPOST_LIST.${fig:T}}: ${MPOST_LIBS}
.endif
MPOST_OBJECTS+= ${_MPOST_LIST.${fig:T}}
.endfor


#
# Post production
#

.for fig in ${_MPOST_FIG}
.for device in ${TEXDEVICE}
.for item in ${_MPOST_LIST.${fig:T}}
.if !target(${item:.mps=.${MPOST_DEVICE.${device}}})
${item:.mps=.${MPOST_DEVICE.${device}}}: ${item}
	${MPOST_TOOL.${MPOST_DEVICE.${device}}} ${.ALLSRC}
.endif
.endfor
.endfor
.endfor


#
# Cleanfiles
#

.for fig in ${_MPOST_FIG}
DISTCLEANFILES+= ${fig:.mp=.log} ${fig:.mp=.mpx}
.endfor

.for fig in ${_MPOST_FIG}
.for item in ${_MPOST_LIST.${fig:T}}
REALCLEANFILES+= ${item}
.endfor
.endfor

.for fig in ${_MPOST_FIG}
.for device in ${TEXDEVICE}
.for item in ${_MPOST_LIST.${fig:T}}
REALCLEANFILES+= ${item:.mps=.${MPOST_DEVICE.${device}}}
.endfor
.endfor
.endfor


.for file in mpxerr.log mpxerr.tex texnum.mpx mptextmp.mp mptextmp.mpx
.if exists(${file})
CLEANFILES+= ${file}
.endif
.endfor

### End of file `tex.mpost.mk'
