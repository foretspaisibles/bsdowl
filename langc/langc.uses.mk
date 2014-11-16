### langc.uses.mk -- Process module options

# Author: Michael Grünewald
# Date: Fri Nov  7 14:25:01 CET 2014

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

# Variables:
#
#  USES [not set]
#    Supported options are debug and profile.

.if !defined(THISMODULE)
.error langc.uses.mk cannot be included directly.
.endif

.if !target(__<langc.uses.mk>__)
__<langc.uses.mk>__:
.if defined(_USES_OPTIONS)

.if defined(_USES_debug_ARGS)
WITH_DEBUG=		yes
.endif

.if defined(_USES_profile_ARGS)
WITH_PROFILE=		yes
.endif
.endif

WITH_DEBUG?=		no
WITH_PROFILE?=		no

.if ${WITH_DEBUG} == yes
CFLAGS+=		-g
.endif

.if ${WITH_PROFILE} == yes && !empty(CC:M*gcc*)
CFLAGS+=		-pg
.endif

.endif # !target(__<langc.uses.mk>__)

### End of file `langc.uses.mk'
