### langc.uses.mk -- Process module options

# Author: Michael Grünewald
# Date: Fri Nov  7 14:25:01 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

# Variables:
#
#  USES [not set]
#    Supported options are debug and profile.

.if !defined(THISMODULE)
.error langc.uses.mk cannot be included directly.
.endif

.if !target(__<langc.uses.mk>__)
__<langc.uses.mk>__:

_USES_shared_VALIDARGS=	elf mach-o

.if defined(_USES_OPTIONS)

.if!empty(_USES_OPTIONS:Mdebug)
_LANGC_WITH_DEBUG=	yes
.endif

.if!empty(_USES_OPTIONS:Mprofile)
_LANGC_WITH_PROFILE=	yes
.endif
.if!empty(_USES_OPTIONS:Mshared)
.if ${_USES_shared_ARGS:[#]} > 1
.error Incorrect "USES+= shared" usage:\
	  at most one argument is expected.
.endif
.if empty(_USES_shared_VALIDARGS:M${_USES_shared_ARGS})
.error Incorrect "USES+= shared:${_USES_shared_ARGS}" usage:\
	  valid arguments are ${_USES_shared_VALIDARGS}.
.endif
_LANGC_SHARED_FORMAT=	${_USES_shared_ARGS}
.endif
.endif

_LANGC_WITH_DEBUG?=	no
_LANGC_WITH_PROFILE?=	no
.if defined(.MAKE.OS)
.if ${.MAKE.OS} == Darwin
_LANGC_SHARED_FORMAT?=	mach-o
.else
_LANGC_SHARED_FORMAT?=	elf
.endif
.endif

.if !defined(_LANGC_SHARED_FORMAT)
.error Unable to determine shared object format.
.endif


.if ${_LANGC_WITH_DEBUG} == yes
CFLAGS+=		-g
.endif

.if ${_LANGC_WITH_PROFILE} == yes && !empty(CC:M*gcc*)
CFLAGS+=		-pg
MKSHAREDLIB+=		-pg
.endif

.endif # !target(__<langc.uses.mk>__)

### End of file `langc.uses.mk'
