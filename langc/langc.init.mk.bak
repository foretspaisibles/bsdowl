### langc.init.mk -- Common initialisation for C modules

# Author: Michael Grünewald
# Date: Fri Nov  7 09:06:28 CET 2014

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
.error langc.init.mk cannot be included directly.
.endif

.if !target(__<langc.init.mk>__)
__<langc.init.mk>__:

.SUFFIXES: .c .o .h .a .so .l .y
.SUFFIXES: .s

#
# Archive manager
#

AR?=			ar
ARFLAGS?=		-cru
MKSHAREDLIB?=		${CC} -shared -Wl,-undefined -Wl,dynamic_lookup

AS?=			as

.include "bps.init.mk"
.include "langc.uses.mk"
.include "langc.module.mk"
.include "langc.external.mk"

.endif # !target(__<langc.init.mk>__)

### End of file `langc.init.mk'
