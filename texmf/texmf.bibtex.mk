### texmf.bibtex.mk -- Support BibTeX

# Author: Michael Grünewald
# Date: Thu Nov 27 09:18:45 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

# Variables:
#
#
#  BSTINPUTS
#   Lookup path for bibiliography styles
#
#
#  BIBINPUTS
#   Lookup path for bibliography databases
#
#
#  BIBTEX
#   Our bibtex command

# Uses:
#
#
#  bibtex: no argument
#   Require the use of bibtex

.if !defined(THISMODULE)
.error texmf.bibtex.mk cannot be included directly.
.endif


.if !target(__<texmf.bibtex.mk>__)
__<texmf.bibtex.mk>__:

BIBTEX?=		bibtex

.if "${.OBJDIR}" != "${.CURDIR}"
BSTINPUTS+=		${.CURDIR}
BIBINPUTS+=		${.CURDIR}
.endif


.if defined(BSTINPUTS)
_BIBTEX_ENV+=		BSTINPUTS='.:${BSTINPUTS:tW:S@ @:@g}:'
.endif

.if defined(BIBINPUTS)
_BIBTEX_ENV+=		BIBINPUTS='.:${BIBINPUTS:tW:S@ @:@g}:'
.endif

.if !empty(_BIBTEX_ENV)
_BIBTEX_TOOL=		${ENVTOOL} ${_BIBTEX_ENV} ${BIBTEX}
.else
_BIBTEX_TOOL=		${BIBTEX}
.endif


.if !empty(_USES_OPTIONS:Mbibtex)
.for document in ${_TEX_DOCUMENT}
.for device in dvi pdf
${COOKIEPREFIX}${document:T}.${device}.toc: ${COOKIEPREFIX}${document:T}.${device}.bib
${COOKIEPREFIX}${document:T}.${device}.bib: ${COOKIEPREFIX}${document:T}.${device}.aux ${SRCS.${document:T}}
	${INFO} 'Processing bibliography database information for ${document:T}'
	${_BIBTEX_TOOL} ${document:T:R}
	@${TOUCH} ${.TARGET}
HARDCOOKIEFILES+=	${COOKIEPREFIX}${document:T}.${device}.bib
REALCLEANFILES+=	${document:R}.bbl
CLEANFILES+=		${document:R}.blg
.endfor
.endfor
.endif

.endif # !target(__<texmf.bibtex.mk>__)

### End of file `texmf.bibtex.mk'
