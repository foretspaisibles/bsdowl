### tex.doc.main.mk -- Produce TeX documents (main part)

# Author: Michaël Le Barbier Grünewald
# Date: Dim  9 sep 2007 14:49:18 CEST
# Lang: fr_FR.ISO8859-15

# $Id$

# Copyright (c) 2006, 2007, 2008, 2009 Michaël Le Barbier Grünewald
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#    1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#    2. Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#
#    3. The name of the author may not be used to endorse or promote
#    products derived from this software without specific prior written
#    permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

#
# Spécialisation de FORMAT
#

# Chaque `device' peut utiliser un format TeX spécifique. La variable
# FORMAT permet d'initialiser les variables FORMAT.${device} avec une
# valeur commune.

.if defined(FORMAT)&&!empty(FORMAT)
.for device in ${TEXDOC_DEVICES}
FORMAT.${_TEX_SUFFIX.${device}}?= ${FORMAT}
.endfor
.endif


#
# Spécialisation de SRCS
#

.for doc in ${_TEX_DOC}
.if defined(SRCS)&&!empty(SRCS)
SRCS.${doc:T}+= ${SRCS}
.endif
.for device in ${TEXDEVICE}
.if defined(SRCS.${doc:T})&&!empty(SRCS.${doc:T})
SRCS.${doc:T}.${device}+= ${SRCS.${doc:T}}
.endif
.endfor
.endfor

#
# Génération des dépendances
#

.for doc in ${_TEX_DOC}
.for device in ${TEXDEVICE}
.if defined(SRCS.${doc:T}.${device})&&!empty(SRCS.${doc:T}.${device})
${doc}.${device}: ${SRCS.${doc:T}.${device}}
.endif
.endfor
.endfor


#
# Pilotes
#

.for device in ${_TEX_DEVICES}
.include "tex.device.${device}.mk"
.endfor

.for driver in ${_TEX_DRIVERS}
.include "tex.driver.${driver}.mk"
.endfor

#
# Files groups
#

FILESGROUPS+= DOCUMENT
DOCUMENTDIR?= ${PREFIX}/Documents${APPLICATIONDIR}
DOCUMENTOWN?= ${DOCOWN}
DOCUMENTGROUP?= ${DOCGROUP}
DOCUMENTMODE?= ${DOCMODE}

do-build: do-build-doc
do-build-doc: ${DOCUMENT}

### End of file `tex.doc.main.mk'
