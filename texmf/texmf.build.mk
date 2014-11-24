### texmf.build.mk -- Build rules for TeX documents

# Author: Michael Grünewald
# Date: Mon Nov 24 14:03:50 CET 2014

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
.error texmf.depend.mk cannot be included directly.
.endif

.if !target(__<texmf.build.mk>__)
__<texmf.build.mk>__:

.tex.dvi:
.if defined(MULTIPASS)&&!empty(MULTIPASS)&&(${DRAFT} == no)
.for pass in ${MULTIPASS}
	${INFO} 'Multipass job for ${.TARGET} (${pass})'
	${_TEX_TOOL.tex} ${.IMPSRC}
.endfor
.else
	${_TEX_TOOL.tex} ${.IMPSRC}
.endif
.if defined(_TEX_VALIDATE)
	${_TEX_VALIDATE}
.endif

.tex.pdf:
.if defined(MULTIPASS)&&!empty(MULTIPASS)&&(${DRAFT} == no)
.for pass in ${MULTIPASS}
	${INFO} 'Multipass job for ${.TARGET} (${pass})'
	${_TEX_TOOL.pdftex} ${.IMPSRC}
.endfor
.else
	${_TEX_TOOL.pdftex} ${.IMPSRC}
.endif

.dvi.ps:
	${DVIPS} -o ${.TARGET} ${.IMPSRC}

.if defined(_TEX_PRINTER)
.for printer in ${_TEX_PRINTER}
.dvi.${printer}.ps:
	${DVIPS} -P ${printer} -o ${.TARGET} ${.IMPSRC}
.endfor
.endif

.mps.png:
	${MP2PNG} -o ${.TARGET} ${.IMPSRC}

.mps.eps:
	${MP2EPS} -o ${.TARGET} ${.IMPSRC}

.eps.pdf:
	${EPSTOPDF} --outfile=${.TARGET} ${.IMPSRC}


.endif # !target(__<texmf.build.mk>__)

### End of file `texmf.build.mk'
