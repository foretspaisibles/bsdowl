### langc.build.mk -- Build products for C modules

# Author: Michael Grünewald
# Date: Fri Nov  7 10:11:57 CET 2014

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
.error langc.build.mk cannot be included directly.
.endif

.if !target(__<langc.build.mk>__)
__<langc.build.mk>__:

CC?=			cc

#
# Prepare the path
#

.if defined(DIRS)
.for dir in ${DIRS}
CFLAGS+=		-I ${dir}
.endfor
.endif

#
# Prepare the linker tool
#

CCLINKTOOL=		${CC}

.for toolvariable in CFLAGS LDFLAGS
.if defined(${toolvariable})&&!empty(${toolvariable})
CCLINKTOOL+=		${${toolvariable}}
.endif
.endfor


#
# Prepare the compiler tool
#

CCCOMPILETOOL=		${CC}

.for toolvariable in CFLAGS
.if defined(${toolvariable})&&!empty(${toolvariable})
CCCOMPILETOOL+=		${${toolvariable}}
.endif
.endfor


ASCOMPILETOOL=		${AS}
.for toolvariable in AFLAGS
.if defined(${toolvariable})&&!empty(${toolvariable})
ASCOMPILETOOL+=		${${toolvariable}}
.endif
.endfor


#
# Compilation rules
#

.c.o:
	${CCCOMPILETOOL} -c -o ${.TARGET} ${.IMPSRC}

.s.o:
	${ASCOMPILETOOL} -o ${.TARGET} ${.IMPSRC}

.endif # !target(__<langc.build.mk>__)

### End of file `langc.build.mk'
