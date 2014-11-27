### texmf.index.mk -- Support Index

# Author: Michael Grünewald
# Date: Thu Nov 27 12:31:26 CET 2014

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

# Variables:
#
#
#  MAKEINDEX
#   Our makeindex command

# Uses:
#
#
#  index: no argument
#   Require the use of index

.if !defined(THISMODULE)
.error texmf.index.mk cannot be included directly.
.endif


.if !target(__<texmf.index.mk>__)
__<texmf.index.mk>__:

MAKEINDEX?=		makeindex

.if !empty(_USES_OPTIONS:Mindex)
.for document in ${_TEX_DOCUMENT}
.for device in dvi pdf
${COOKIEPREFIX}${document:T}.${device}.toc: ${COOKIEPREFIX}${document:T}.${device}.idx
${COOKIEPREFIX}${document:T}.${device}.idx: ${COOKIEPREFIX}${document:T}.${device}.aux ${SRCS.${document:T}}
	${INFO} 'Processing index database information for ${document:T}'
	${MAKEINDEX} ${document:T:R}
	@${TOUCH} ${.TARGET}
COOKIEFILES+=		${COOKIEPREFIX}${document:T}.${device}.idx
CLEANFILES+=		${document:R}.idx
CLEANFILES+=		${document:R}.ind
CLEANFILES+=		${document:R}.ilg
.endfor
.endfor
.endif

.endif # !target(__<texmf.index.mk>__)

### End of file `texmf.index.mk'
