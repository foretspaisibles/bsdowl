### tex.files.mk -- Installation de fichiers pour un système TeX

# Author: Michaël Le Barbier Grünewald
# Date: Dim  9 sep 2007 17:32:25 CEST
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

### SYNOPSIS

# TEXGROUP = TEXSRC
# TEXSRC+= lmodern.sty
# TEXSRC+= ts1lmvtt.fd
# ...
# FORMAT = latex
# APPLICATION = lm
# TEXDIR = ${TEXMFDIR}/tex/${FORMAT}${APPLICATIONDIR}
#
# .include "tex.files.ml"

# Le fragment précédent s'arrange pour que `build' dépende des
# fichiers figurant dans la liste TEX et pour que `install' installe
# ces fichiers dans ${TEXDIR}.

TEXGROUP?= TEXSRC
FILESGROUPS+= ${TEXGROUP}
FORMAT?= plain
APPLICATION?= misc
TEXMFDIR?= ${PREFIX}/share/texmf
WEB2CDIR?= ${TEXMFDIR}/web2c
DOCUMENTDIR?= ${TEXMFDIR}/doc/${FORMAT}${APPLICATIONDIR}
${TEXGROUP}DIR?= ${TEXMFDIR}/tex/${FORMAT}${APPLICATIONDIR}

.if defined(${TEXGROUP})&&!empty(${TEXGROUP})
post-install: post-install-mktexlsr
post-install-mktexlsr:
.if ${UID} == 0
	env -u TEXMFHOME mktexlsr
.else
	mktexlsr
.endif
.endif

.include "bps.init.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `tex.files.mk'
