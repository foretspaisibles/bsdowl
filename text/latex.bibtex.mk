### latex.bibtex.mk -- Support pour BibTeX

# Author: Michaël Le Barbier Grünewald
# Date: Ven 11 jul 2008 22:17:23 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

# Copyright (c) 2008, 2009 Michaël Le Barbier Grünewald
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


### SYNOPSIS

# USE_BIBTEX = yes
# .include "latex.bibtex.mk"


### DESCRIPTION

# Si USE_BIBTEX vaut yes, les fichiers auxiliaires associés aux
# fichiers objet énumérés par les variables _TEX_DVI, _TEX_PS et
# _TEX_PDF sont traités avec BIBTEX en vue de la production finale du
# document.
#
# L'étape de traitement de la base de donnée prend place entre la
# passe `aux' et la passe `toc' des travaux en plusieurs traitement de
# LaTeX.

# BSTINPUTS
#
#  Chemins de recherche pour les styles de bibliographie.
#
#  Si la variable BSTINPUTS est définie, celle-ci est exportée vers
#  l'environnement de la commande BIBTEX. De plus la variable
#  USE_BIBTEX reçoit `yes' pour valeur implicite.

# BIBINPUTS
#
#  Chemins de recherche pour les bases de données bibliographiques.
#
#  Si la variable BIBINPUTS est définie, celle-ci est exportée vers
#  l'environnement de la commande BIBTEX. De plus la variable
#  USE_BIBTEX reçoit `yes' pour valeur implicite.


### IMPLÉMENTATION

.if !target(__<latex.bibtex.mk>__)
__<latex.bibtex.mk>__:

BIBTEX?= bibtex

#
# Calcul de l'environnement d'éxécution de la commande BIBTEX
#

_BIBTEX_ENV =

.if defined(BSTINPUTS)
_BIBTEX_ENV+= BSTINPUTS='${BSTINPUTS}'
USE_BIBTEX?= yes
.endif

.if defined(BIBINPUTS)
_BIBTEX_ENV+= BIBINPUTS='${BIBINPUTS}'
USE_BIBTEX?= yes
.endif

.if !empty(_BIBTEX_ENV)
_BIBTEX_CMD = env ${_BIBTEX_ENV} ${BIBTEX}
.else
_BIBTEX_CMD = ${BIBTEX}
.endif

USE_BIBTEX?= no

.if ${USE_BIBTEX} == yes
.for var in _TEX_DVI _TEX_PDF _TEX_PS
.if defined(${var})&&!empty(${var})
.for doc in ${${var}}
${_TEX_COOKIE}${doc:T}.toc: ${_TEX_COOKIE}${doc:T}.bib
${_TEX_COOKIE}${doc:T}.bib: ${_TEX_COOKIE}${doc:T}.aux
	${INFO} 'Processing bibliography database information for ${doc:T}'
	${_BIBTEX_CMD} ${doc:R}
COOKIEFILES+= ${_TEX_COOKIE}${doc:T}.bib
CLEANFILES+= ${doc:R}.bbl
CLEANFILES+= ${doc:R}.blg
.endfor
.endif
.endfor
.endif

.endif # !target(__<latex.bibtex.mk>__)

### End of file `latex.bibtex.mk'
