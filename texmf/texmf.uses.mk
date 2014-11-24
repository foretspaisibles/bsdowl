### texmf.uses.mk -- Process module options

# Author: Michael Grünewald
# Date: Mon Nov 24 14:00:50 CET 2014

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

.if !defined(THISMODULE)
.error texmf.uses.mk cannot be included directly.
.endif

.if !target(__<texmf.uses.mk>__)
__<texmf.uses.mk>__:

.endif # !target(__<texmf.uses.mk>__)

### End of file `texmf.uses.mk'
