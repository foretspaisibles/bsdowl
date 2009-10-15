### tex.init.mk -- Service d'initialisation

# Author: Michaël Le Barbier Grünewald
# Date: Dim  9 sep 2007 14:49:18 CEST
# Lang: fr_FR.ISO8859-15

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
# 
# Copyright (C) Michaël Le Barbier Grünewald - 2006-2009
# 
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

.if !target(__<tex.init.mk>__)
__<tex.init.mk>__:

.include "texmf.init.mk"

DRAFT?= no
TEXDEVICE?= dvi
TEX?= pdftex
TEX.dvi?= tex
TEX.pdf?= pdftex
TEX.ps?= ${TEX.dvi}

# Les variables énumérées par _TEX_VARS sont des variables d'instance
# supportant une spécialisation pour chaque cible.
_TEX_VARS+= TEXINPUTS TEXMFOUTPUT TEXFORMATS TEXPOOL TFMFONTS
_TEX_VARS+= INTERACTION JOBNAME TEXFORMATS
_TEX_VARS+= COMMENT PROGNAME

_TEX_DOC?= ${DOCS:.tex=}

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
