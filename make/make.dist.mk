### make.dist.mk -- Préparer la distribution des sources

# Author: Michaël Grünewald
# Date: Sam 19 avr 2008 00:15:12 CEST
# Lang: fr_FR.ISO8859-1

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


### SYNOPSIS

# DISTDIR = /publish		# Where files are created, defaults to .
# DISTVERSION = 1.2
# DISTNAME = software
# DISTCOMPRESSION=gzip bzip2
# DISTEXCLUDE+=
# .include "make.dist.mk"
#
# Après:
# DISTFILES = ${DISTNAME}-${DISTVERSION}.tar.gz
# DISTFILES+= ${DISTNAME}-${DISTVERSION}.tar.bz2

### DESCRIPTION

# Crée des fichiers de distribution du projet.
# Avant de créer ces fichiers, on éxécute `distclean'
# La liste DISTFILES est caclulée automatiquement et peut être
# utilisée par d'autre modules.
#
# La valeur de DISTNAME peut être devinée à partir de `.CURDIR'
#
# Les fichiers automatiquement exclcus sont:
#  * les fichiers CVS .cvsignore et .svn
#  * les fichiers apparaissant dans DISTFILES
#  * les fichiers objets associés aux sources énumérées dans CONFIGURE

.if !target(__<make.dist.mk>__)
__<make.dist.mk>__:
DISTDIR?=${.OBJDIR}
.if !defined(DISTVERSION)
.if defined(VERSION)&&!empty(VERSION)
DISTVERSION = ${VERSION}
.else
DISTVERSION = 0.0
.endif
.endif
DISTNAME?= ${.CURDIR:T}
DISTCOMPRESSION?=gzip bzip2
DISTCOMPRESSION.suffix.gzip=tar.gz
DISTCOMPRESSION.suffix.bzip2=tar.bz2
DISTCOMPRESSION.flag.gzip=-j
DISTCOMPRESSION.flag.bzip2=-z
.for c in ${DISTCOMPRESSION}
DISTFILES+= ${DISTDIR}/${DISTNAME}-${DISTVERSION}.${DISTCOMPRESSION.suffix.${c}}
.endfor
#
# Inutile d'ajouter les fichiers de distribution à l'archive.
# La ligne ${DISTNAME}-${DISTVERSION}/${DISTNAME}-${DISTVERSION}
# set lorsque DISTDIR=${.CURDIR}
DISTEXCLUDE+= ${DISTFILES:T}
DISTEXCLUDE+= ${DISTNAME}-${DISTVERSION}/${DISTNAME}-${DISTVERSION}
.for f in CVS .cvsignore .svn
.if exists(${f})
DISTEXCLUDE+=${f}
.endif
.endfor
.if defined(CONFIGURE)&&!empty(CONFIGURE)
.for f in ${CONFIGURE:.in=}
.if exists(${f})
DISTEXCLUDE+=${f}
.endif
.endfor
.endif
.for c in ${DISTCOMPRESSION}
${DISTDIR}/${DISTNAME}-${DISTVERSION}.${DISTCOMPRESSION.suffix.${c}}:
	${LN} -s ${.CURDIR} ${DISTDIR}/${DISTNAME}-${DISTVERSION}
	${TAR} -c\
	${DISTCOMPRESSION.flag.${c}}\
	-f ${.TARGET}\
	-C ${DISTDIR}\
	-H\
	${DISTEXCLUDE:S/^/-W exclude=/} ${DISTNAME}-${DISTVERSION}
	${RM} -f ${DISTDIR}/${DISTNAME}-${DISTVERSION}
.endfor
dist: distclean ${DISTFILES}
.for f in ${DISTFILES}
.if exists(${f})
REALCLEANFILES+= ${f}
.endif
.endfor
.endif # !target(__<make.dist.mk>__)

### End of file `make.dist.mk'
