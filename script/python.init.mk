### python.init.mk -- Initialisation for Python support

# Author: Michael Grünewald
# Date: Sat Nov 22 12:52:58 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

.if !defined(THISMODULE)
.error python.init.mk cannot be included directly.
.endif

.if !target(__<python.init.mk>__)
__<python.init.mk>__:

.include "bps.init.mk"
.include "python.uses.mk"

.if defined(PYTHONVERSION)
PYTHONLIBDIR?=		${PREFIX}/lib/python${PYTHONVERSION}/site-packages${PACKAGEDIR}
.else
.error The variable PYTHONVERSION is not set.
.endif

.endif # !target(__<python.init.mk>__)

### End of file `python.init.mk'
