### tex.init.mk -- Service d'initialisation

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

.if !target(__<tex.init.mk>__)
__<tex.init.mk>__:

TEXMFDIR?= ${PREFIX}/share/texmf
WEB2CDIR?= ${TEXMFDIR}/web2c

TEXDEVICE?= dvi
TEX?= tex
DVITEX?= ${TEX}
PDFTEX?= pdftex

# Les variables énumérées par _TEX_VARS sont des variables d'instance
# supportant une spécialisation pour chaque cible.
_TEX_VARS+= TEXINPUTS TEXMFOUTPUT TEXFORMATS TEXPOOL TFMFONTS
_TEX_VARS+= INTERACTION JOBNAME TEXFORMATS
_TEX_VARS+= COMMENT PROGNAME

_TEX_DOC = ${DOCS:.tex=}

_TEX_DEVICES?= pdf ps dvi

_TEX_SUFFIX.dvi = .dvi
_TEX_SUFFIX.pdf = .pdf
_TEX_SUFFIX.ps = .ps

_TEX_DRIVER.dvi?= dvi
_TEX_DRIVER.pdf?= pdftex
_TEX_DRIVER.ps?= dvips

_TEX_COOKIE = .cookie.

COOKIEFILES =

do-clean-cookies:
	@${RM} -f ${COOKIEFILES}

do-clean: do-clean-cookies

.for device in ${_TEX_DEVICES}
_TEX_DRIVERS+= ${_TEX_DRIVER.${device}}
.endfor

.endif #!target(__<tex.init.mk>__)

### End of file `tex.init.mk'
