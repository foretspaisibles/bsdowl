### texmf.draft.mk -- Produce a draft

# Author: Michael Grünewald
# Date: Wed Nov 26 17:42:35 CET 2014

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

.if !target(__<texmf.init.mk>__)
.error texmf.draft.mk cannot be included directly.
.endif


.if !target(__<texmf.draft.mk>__)
__<texmf.draft.mk>__:

.if !empty(_USES_OPTIONS:Mdraft)
.if empty(_USES_draft_ARGS)\
	  ||!empty(_USES_draft_ARGS:Mauto)\
	  ||!empty(_USES_draft_ARGS:Mcvs)\
	  ||!empty(_USES_draft_ARGS:Mtime)
_TEXMF_DRAFTSTAMP_CMD=	date '+%Y-%m-%d'
.elif !empty(_USES_draft_ARGS:Mgit)
_TEXMF_DRAFTSTAMP_CMD=	git log -1 --pretty=tformat:'%ai %h' | tr ' ' '_'
.elif !empty(_USES_draft_ARGS:Msvn)
_TEXMF_DRAFTSTAMP_CMD=	svn log -l 1| awk -F'_[|]_'\
	  'NR == 2 {gsub(" ","_"); gsub("[(].*[)]",""); print($$3 $$1);}'
.else
.error Incorrect "USES+= draft:${_USES_draft_ARGS}" usage:\
	  valid arguments are ${_USES_draft_VALIDARGS}.
.endif

.if !defined(TEXDRAFTSTAMP)
TEXDRAFTSTAMP!=		(cd ${.CURDIR} && ${_TEXMF_DRAFTSTAMP_CMD})
.endif

.for document in ${_TEX_DOCUMENT}
.for device in ${TEXDEVICE}
.if defined(TEXDOCNAME.${document:T}.${device})
DOCNAME.${document:T}.${device}:=	${TEXDOCNAME.${document:T}}_${TEXDRAFTSTAMP}.${device}
.else
DOCNAME.${document:T}.${device}=	${document:T}_${TEXDRAFTSTAMP}.${device}
.endif
.endfor
.endfor

.endif

.endif # !target(__<texmf.draft.mk>__)

### End of file `texmf.draft.mk'
