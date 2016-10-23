### texmf.uses.mk -- Process module options

# Author: Michael Grünewald
# Date: Mon Nov 24 14:00:50 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

.if !defined(THISMODULE)
.error texmf.uses.mk cannot be included directly.
.endif

.if !target(__<texmf.uses.mk>__)
__<texmf.uses.mk>__:

_USES_texinteraction_VALIDARGS=batch nonstop scroll errorstop
_USES_draft_VALIDARGS=time git svn cvs auto

.if !empty(_USES_OPTIONS:Mtexinteraction)
.if ${_USES_texinteraction_ARGS:[#]} != 1
.error Incorrect "USES+= texinteraction" usage:\
	  exactly one argument is expected.
.endif
.if empty(_USES_texinteraction_VALIDARGS:M${_USES_texinteraction_ARGS})
.error Incorrect "USES+= texinteraction:${_USES_texinteraction_ARGS}" usage:\
	  valid arguments are ${_USES_texinteraction_VALIDARGS}.
.endif
.endif

.if !empty(_USES_OPTIONS:Mdraft)
.if ${_USES_draft_ARGS:[#]} > 1
.error Incorrect "USES+= draft" usage:\
	  at most one argument is expected.
.endif
.if empty(_USES_draft_VALIDARGS:M${_USES_draft_ARGS})
.error Incorrect "USES+= draft:${_USES_draft_ARGS}" usage:\
	  valid arguments are ${_USES_draft_VALIDARGS}.
.endif
.endif

.endif # !target(__<texmf.uses.mk>__)

### End of file `texmf.uses.mk'
