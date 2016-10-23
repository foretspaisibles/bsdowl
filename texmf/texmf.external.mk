### texmf.external.mk -- Use external resources

# Author: Michael Grünewald
# Date: Mon Nov 24 14:01:36 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

.if !defined(THISMODULE)
.error texmf.external.mk cannot be included directly.
.endif

.if !target(__<texmf.external.mk>__)
__<texmf.external.mk>__:

.endif # !target(__<texmf.external.mk>__)

### End of file `texmf.external.mk'
