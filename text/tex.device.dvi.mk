### tex.device.dvi.mk -- Réclame la production de fichiers DVI

# Author: Michaël Grünewald
# Date: Dim  9 sep 2007 14:49:18 CEST
# Lang: fr_FR.ISO8859-15

# $Id$

# Copyright (c) 2008, Michaël Grünewald
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

# Ce module analyse les paramètres reçus de tex.texdoc.mk et passe
# commande à tex.driver.dvi.mk pour la production des fichiers DVI
# recquis par ces paramètres.


#
# Commande la création de ${doc}.dvi
#

.for doc in ${_TEX_DOC}
_TEX_DVI+= ${doc}.dvi
.endfor


#
# Spécialisation des variables
#

.for doc in ${_TEX_DOC}
.for var in ${_TEX_VARS}
.if defined(${var}.${doc:T})&&!empty(${var}.${doc:T})&&!defined(${var}.${doc:T}.dvi)
${var}.${doc:T}.dvi = ${${var}.${doc:T}}
.endif
.endfor
.endfor


#
# Build and install files
#

.if !empty(TEXDEVICE:Mdvi)
DOCUMENT+= ${_TEX_DOC:=.dvi}
.endif

### End of file `tex.device.dvi.mk'
