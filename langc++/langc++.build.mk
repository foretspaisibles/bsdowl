### langc++.build.mk -- Build products for C modules

# Author: Michael Grünewald
# Date: Sat Dec 20 18:17:31 CET 2014

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
.error langc++.build.mk cannot be included directly.
.endif

.if !target(__<langc++.build.mk>__)
__<langc++.build.mk>__:

CXX?=			c++

#
# Prepare the path
#

.if defined(DIRS)
.for dir in ${DIRS}
CXXFLAGS+=		-I${dir}
.endfor
.endif

#
# Prepare the linker tool
#

CXXLINKTOOL=		${CXX}

.for toolvariable in CXXFLAGS LDFLAGS
.if defined(${toolvariable})&&!empty(${toolvariable})
CXXLINKTOOL+=		${${toolvariable}}
.endif
.endfor


#
# Prepare the compiler tool
#

CXXCOMPILETOOL=		${CXX}

.for toolvariable in CXXFLAGS
.if defined(${toolvariable})&&!empty(${toolvariable})
CXXCOMPILETOOL+=	${${toolvariable}}
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

.cpp.o:
	${CXXCOMPILETOOL} -c -o ${.TARGET} ${.IMPSRC}

.s.o:
	${ASCOMPILETOOL} -o ${.TARGET} ${.IMPSRC}

.endif # !target(__<langc++.build.mk>__)

### End of file `langc++.build.mk'
