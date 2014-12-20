### langc.depend.mk -- Automatic generation of dependencies

# Author: Michael Grünewald
# Date: Fri Nov  7 16:15:56 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald
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

MKDEPCMD?=		${CC} -MM

.for source in ${_LANGC_SRCS}
.depend: ${${source}}
.endfor

MKDEPTOOL=		${MKDEPCMD}
.if defined(CFLAGS)&&!empty(CFLAGS:M-I*)
MKDEPTOOL+=		${CFLAGS:S@-I @-I@gW:M-I*:S@-I@-I @g}
.endif

.depend:
	${MKDEPTOOL} ${.ALLSRC} > ${.TARGET}

do-depend:		.depend

DISTCLEANFILES+=	.depend

.endif # !target(__<langc.depend.mk>__)

### End of file `langc.depend.mk'
