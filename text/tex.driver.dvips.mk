### tex.driver.dvips.mk -- Organise la production des fichiers PostScript

# Author: Michaël Grünewald
# Date: Dim  9 sep 2007 14:49:18 CEST
# Lang: fr_FR.ISO8859-15

# $Id$

# Copyright (c) 2006, 2007, 2008, Michaël Grünewald
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

.if !target(__<tex.driver.dvips.mk>__)

DVIPS?= dvips

#
# Spécialisation des variables
#

# Par ordre de spécialisation croissante: DVIPSFLAGS,
# DVIPSFLAGS.document, DVIPSFLAGS.document.ps,
# DVIPSFLAGS.document.printer.ps.

.for var in DVIPSFLAGS DVIPS
.for doc in ${_TEX_DOC}
.if defined(${var})&&!empty(${var})&&!defined(${var}.${doc:T})
${var}.${doc:T} = ${${var}}
.endif
.if defined(${var}.${doc:T})&&!empty(${var}.${doc:T})&&!defined(${var}.${doc:T}.ps)
${var}.${doc:T}.ps = ${${var}.${doc:T}}
.endif
.for printer in ${PRINTERS}
.if defined(${var}.${doc:T}.ps)&&!empty(${var}.${doc:T}.ps)&&!defined(${var}.${doc:T}.${printer}.ps)
${var}.${doc:T}.${printer}.ps = ${${var}.${doc:T}.ps}
.endif
.endfor
.endfor
.endfor

#
# Création des lignes de commande
#

.for ps in ${_TEX_PS}
_DVIPS_BUILD.${ps:T} = ${DVIPS}
.for printer in ${PRINTERS}
# Le prédicat == insiste pour avoir une variable à gauche. La
# bidouille __loop__ le satisfait.
__loop__=${printer}
.if ${__loop__} == ${ps:C/.ps$//:C/^.*\.//}
_DVIPS_BUILD.${ps:T}+= -P ${printer}
.endif
.undef __loop__
.endfor
.if defined(DVIPSFLAGS.${ps:T})&&!empty((DVIPSFLAGS.${ps:T})
_DVIPS_BUILD.${ps:T}+= ${DVIPSFLAGS.${ps:T}}
.endif
_DVIPS_BUILD.${ps:T}+= -o ${ps} ${ps}.dvi
.endfor

#
# Recettes
#

.for ps in ${_TEX_PS}
${ps}: ${ps}.dvi
	${_DVIPS_BUILD.${ps:T}}
.endfor

#
# Cleanfiles
#

.for ps in ${_TEX_PS}
CLEANFILES+= ${ps}
.endfor

.endif #!target(__<tex.driver.dvips.mk>__)

### End of file `tex.driver.dvips.mk'
