### langc.external.mk -- Use external resources

# Author: Michael Grünewald
# Date: Fri Nov  7 14:58:35 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


### SYNOPSIS

### DESCRIPTION

.if !defined(THISMODULE)
.error langc.external.mk cannot be included directly.
.endif

.if !target(__<langc.external.mk>__)
__<langc.external.mk>__:

.endif # !target(__<langc.external.mk>__)

### End of file `langc.external.mk'
