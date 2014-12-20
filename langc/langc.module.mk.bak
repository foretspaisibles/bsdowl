### langc.module.mk -- Take in account other modules of the project

# Author: Michael Grünewald
# Date: Fri Nov  7 14:58:12 CET 2014

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


### DESCRIPTION

# Take into account other modules of the package.

.if !defined(THISMODULE)
.error langc.module.mk cannot be included directly.
.endif

.if !target(__<langc.module.mk>__)
__<langc.module.mk>__:

# Source files, like .c or .h, can also appear under ${WRKDIR}
# because they might be produce by an external program, like lex, yacc
# or m4.

.for module_path in ${_MODULE_langc.prog_ARGS}
.if empty(CFLAGS:M${SRCDIR}/${module_path})
CFLAGS+=		-I ${SRCDIR}/${module_path}
.endif
.if empty(CFLAGS:M${WRKDIR}/${module_path})
CFLAGS+=		-I ${WRKDIR}/${module_path}
.endif
.PATH.c:		${SRCDIR}/${module_path}
.PATH.c:		${WRKDIR}/${module_path}
.PATH.h:		${SRCDIR}/${module_path}
.PATH.h:		${WRKDIR}/${module_path}
.PATH.o:		${WRKDIR}/${module_path}
.endfor

.for module_path in ${_MODULE_langc.lib_ARGS}
.if empty(CFLAGS:M${SRCDIR}/${module_path})
CFLAGS+=		-I ${SRCDIR}/${module_path}
.endif
.if empty(CFLAGS:M${WRKDIR}/${module_path})
CFLAGS+=		-I ${WRKDIR}/${module_path}
.endif
.if empty(LDFLAGS:M${WRKDIR}/${module_path})
LDFLAGS+=		-L ${WRKDIR}/${module_path}
.endif
.PATH.h:		${SRCDIR}/${module_path}
.PATH.h:		${WRKDIR}/${module_path}
.PATH.o:		${WRKDIR}/${module_path}
.PATH.a:		${WRKDIR}/${module_path}
.PATH.so:		${WRKDIR}/${module_path}
.endfor

.if ${THISMODULE} == langc.prog
LIBS+=			${PRODUCT_langc.lib}
.endif

.endif # !target(__<langc.module.mk>__)

### End of file `langc.module.mk'
