### python.uses.mk -- Options for Python scripts

# Author: Michael Grünewald
# Date: Sat Nov 22 12:52:43 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


.if !defined(THISMODULE)
.error python.uses.mk cannot be included directly.
.endif

.if !target(__<python.uses.mk>__)
__<python.uses.mk>__:

.if!empty(_USES_python_ARGS:M[0-9].[0-9])
PYTHONVERSION=		${_USES_python_ARGS:M[0-9].[0-9]}
.endif

.endif # !target(__<python.uses.mk>__)

### End of file `python.uses.mk'
