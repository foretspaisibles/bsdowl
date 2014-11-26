### texmf.clean.mk -- Clean special files

# Author: Michael Grünewald
# Date: Mon Nov 24 07:50:43 CET 2014

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
#  _TEX_DOCUMENT
#   The list of TeX documents
#
#
#  TEXDEVICE
#   The list of TeX devices
#
#  _MPOST_DOCUMENT
#   The list of METAPOST documents
#
#  MPDEVICE
#   The lsit of METAPOST devices

.if !target(__<texmf.init.mk>__)
.error texmf.clean.mk cannot be included directly.
.endif

.if !target(__<texmf.clean.mk>__)
__<texmf.clean.mk>__:

.for document in ${_TEX_DOCUMENT}
.if empty(TEXDEVICE:Mdvi)&&!empty(TEXDEVICE:M*ps)
CLEANFILES+=		${document}.dvi
.endif
.for suffix in ${TEXDEVICE:C@^@.@} ${_TEX_AUX_SUFFIXES}
CLEANFILES+=		${document}${suffix}
.endfor
.endfor

.if exists(missfont.log)
CLEANFILES+=		missfont.log
.endif

.for file in mpxerr.log mpxerr.tex texnum.mpx mptextmp.mp mptextmp.mpx
.if exists(${file})
CLEANFILES+=		${file}
.endif
.endfor

.endif

### End of file `texmf.clean.mk'
