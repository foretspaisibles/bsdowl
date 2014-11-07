### langc.depend.mk -- Automatic generation of dependencies

# Author: Michael Grünewald
# Date: Fri Nov  7 16:15:56 CET 2014

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

### DESCRIPTION


.if !defined(THISMODULE)
.error langc.depend.mk cannot be included directly.
.endif

.if !target(__<langc.depend.mk>__)
__<langc.depend.mk>__:

.if ${CC} != "cc"
MKDEPCMD?=		CC='${CC}' mkdep
.else
MKDEPCMD?=		mkdep
.endif

.for source in ${_LANGC_SRCS}
.depend: ${${source}}
.endfor

MKDEPTOOL=		${MKDEPCMD}
.for toolvariable in CFLAGS
.if defined(${toolvariable})&&!empty(${toolvariable})
MKDEPTOOL+=		${${toolvariable}}
.endif
.endfor


.depend:
	${MKDEPTOOL} ${.ALLSRC}

do-depend:		.depend

DISTCLEANFILES+=	.depend

.endif # !target(__<langc.depend.mk>__)

### End of file `langc.depend.mk'
