### langc.external.mk -- Use external resources

# Author: Michael Grünewald
# Date: Fri Nov  7 14:58:35 CET 2014

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
.error langc.external.mk cannot be included directly.
.endif

.if !target(__<langc.external.mk>__)
__<langc.external.mk>__:

.endif # !target(__<langc.external.mk>__)

### End of file `langc.external.mk'
