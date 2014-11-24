### texmf.init.mk -- Initialisation for TeX and METAPOST

# Author: Michael Grünewald
# Date: Dim Oct  4 2009 11:59:26 CEST

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

.if !defined(THISMODULE)
.error texmf.init.mk cannot be included directly.
.endif

.if !target(__<texmf.init.mk>__)
__<texmf.init.mk>__:

#
# Directories
#

TEXMFDIR?=		${datarootdir}/texmf
WEB2CDIR?=		${TEXMFDIR}/web2c


#
# Databases
#

TEXDEVICE?=		pdf

TEX?=			pdftex
TEX.pdftex?=		pdftex
TEX.tex?=		tex
DVIPS?=			dvips
MPOST?=			mpost
MP2EPS?=		mp2eps
MP2PNG?=		mp2png
MP2PDF?=		mp2pdf
EPSTOPDF?=		epstopdf

_TEX_ENGINES=		tex pdftex
_TEX_DEVICES?=		pdf ps dvi
_TEX_SUFFIX.dvi=	.dvi
_TEX_SUFFIX.pdf=	.pdf
_TEX_SUFFIX.ps=		.ps

_TEX_SUFFIXES?=		.tex
_TEX_AUX_SUFFIXES?=	.log

.for device in ${TEXDEVICE}
.if empty(_TEX_DEVICES:M${device})
_TEX_DEVICES+=		${device}
.endif
.endfor

.if !empty(TEXDEVICE:M*.ps)
_TEX_PRINTER=		${TEXDEVICE:M*.ps:.ps=}
.endif

.SUFFIXES: ${_TEX_SUFFIXES}
.SUFFIXES: ${_TEX_DEVICES:C@^@.@}

.if defined(_TEX_PRINTER)
.SUFFIXES: ${_TEX_PRINTER:C@^@.@:C@$@.ps@}
.endif

.SUFFIXES: .mps .png .pdf .svg .eps

#
# TeX environment
#

.if defined(TEXINPUTS)&&!empty(TEXINPUTS)
.if !defined(USE_STRICT_TEXINPUTS)|| ${USE_STRICT_TEXINPUTS} != yes
_TEX_ENV+=		TEXINPUTS=".:${TEXINPUTS:tW:S@ @:@g}:"
.else
_TEX_ENV+=		TEXINPUTS="${TEXINPUTS:tW:S@ @:@g}"
.endif
.endif

.for variable in TEXMFOUTPUT TEXFORMATS TEXPOOL TFMFONTS
.if defined(${variable})&&!empty(${variable})
_TEX_ENV+=		${variable}=${${variable}:Q}
.endif
.endfor


#
# TeX flags
#

.if defined(INTERACTION)&&!empty(INTERACTION)
_TEX_FLAGS+=		-interaction ${INTERACTION}mode
.endif

.if defined(JOBNAME)&&!empty(JOBNAME)
_TEX_FLAGS+=		-jobname ${JOBNAME}
.endif

.if defined(COMMENT)&&!empty(COMMENT)
_TEX_FLAGS+=		-output-comment ${COMMENT}
.endif

.if defined(PROGNAME)&&!empty(PROGNAME)
_TEX_FLAGS+=		-progname ${PROGNAME}
.endif


#
# TeX tools
#

.for engine in ${_TEX_ENGINES}
.if defined(_TEX_ENV)&&!empty(_TEX_ENV)
_TEX_TOOL.${engine}=	${ENVTOOL} ${_TEX_ENV}
.endif
_TEX_TOOL.${engine}+=	${TEX.${engine}}
.if defined(FORMAT.${engine})
_TEX_TOOL.${engine}+=	-fmt ${FORMAT.${engine}}
.endif
.if defined(_TEX_FLAGS)
_TEX_TOOL.${engine}+=	${_TEX_FLAGS}
.endif
.endfor


#
# METAPOST environment
#

.if defined(MPTEX)
_MPOST_ENV+=		TEX=${MPTEX}
.endif

.if defined(MPINPUTS)&&!empty(MPINPUTS)
.if !defined(USE_STRICT_MPINPUTS)|| ${USE_STRICT_MPINPUTS} != yes
_MPOST_ENV+=		MPINPUTS=".:${MPINPUTS:tW:S@ @:@g}:"
.else
_MPOST_ENV+=		MPINPUTS="${MPINPUTS:tW:S@ @:@g}"
.endif
.endif

.if defined(MPTEXINPUTS)&&!empty(MPTEXINPUTS)
.if !defined(USE_STRICT_MPTEXINPUTS)|| ${USE_STRICT_MPTEXINPUTS} != yes
_MPOST_ENV+=		TEXINPUTS=".:${MPTEXINPUTS:tW:S@ @:@g}:"
.else
_MPOST_ENV+=		TEXINPUTS="${MPTEXINPUTS:tW:S@ @:@g}"
.endif
.elif defined(TEXINPUTS)&&!empty(TEXINPUTS)
.if !defined(USE_STRICT_TEXINPUTS)|| ${USE_STRICT_TEXINPUTS} != yes
_MPOST_ENV+=		TEXINPUTS=".:${TEXINPUTS:tW:S@ @:@g}:"
.else
_MPOST_ENV+=		TEXINPUTS="${TEXINPUTS:tW:S@ @:@g}"
.endif
.endif

.for variable in TEXMFOUTPUT TEXFORMATS TEXPOOL TFMFONTS
.if defined(${variable})&&!empty(${variable})
_MPOST_ENV+=		${variable}=${${variable}:Q}
.endif
.endfor


#
# METAPOST tool
#

.if defined(_MPOST_ENV)&&!empty(_MPOST_ENV)
_MPOST_TOOL=		${ENVTOOL} ${_MPOST_ENV} ${MPOST}
.else
_MPOST_TOOL=		${MPOST}
.endif


#
# Path
#

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


#
# METAPOST include
#

.if exists(.depend.mpost)
.include ".depend.mpost"
.endif

.include "bps.init.mk"
.include "texmf.uses.mk"
.include "texmf.module.mk"
.include "texmf.external.mk"
.include "texmf.draft.mk"

.endif #!target(__<texmf.init.mk>__)

### End of file `texmf.init.mk'
