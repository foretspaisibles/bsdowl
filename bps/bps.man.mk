### bps.man.mk -- Install manual pages

# Auteur: Michael Grünewald
# Date: Sat Oct 18 11:35:50 CEST 2014

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


### SYNOPSIS

# .include "bps.man.mk"


### DESCRIPTION

# This library defines targets to build and install manual pages and
# hooks them to the build and installation processes.
#
# The list of manual pages to install must be conveyed by MAN. Other
# variables can be used to configure the process, as described
# hereafter.
#
# Manual pages are automatically installed in the adequate
# subdirectory based on their suffix.  However, the list of recognised
# suffixes is finite and held by the MANSECTIONS variable.


### VARIABLES

# DESTDIR [not set]
#  Change the tree where the manual pages get installed.
#
# MAN [not set]
#  Manual pages to be installed.
#
# MANDIR [${mandir}]
#  Base path for manual installation.
#
# MANOWN [${SHAREOWN}]
#  Manual owner.
#
# MANGRP [${SHAREGRP}]
#  Manual group.
#
# MANMODE [${SHAREMODE}]
#  Manual mode.
#
# MANSECTIONS [1 2 3 4 5 6 7 8 9 n l]
#  Manual sections.
#
# MANFILTER [not set]
#  Filter processing raw man pages before compressing or installing.
#
# DIRS [not set]
#  Directories that are searched for manual pages
#
# _MAN_AUTO [not set]
#  List of manual pages automatically added to MAN if they exist


### TARGETS

# buildman
#  Filter and compress manual pages.
#
# installman
#  Install manual pages.
#
# installmandirs
#  Install directories hosting manual pages.


### IMPLEMENTATION

.if !target(__<bps.man.mk>__)
__<bps.man.mk>__:

MANDIR?=		${mandir}
MANMODE?=		${SHAREMODE}
MANOWN?=		${SHAREOWN}
MANGRP?=		${SHAREGRP}
MANSECTIONS?=		1 2 3 4 5 6 7 8 9 n l
INSTALL_MAN?=		${INSTALL} -o ${MANOWN} -g ${MANGRP} -m ${MANMODE}
MANCOMPRESSCMD?=	gzip
MANCOMPRESSEXT?=	.gz

.SUFFIXES: ${MANSECTIONS:S@^@.@}

.if defined(DIRS)
.for section in ${MANSECTIONS}
.SUFFIXES: .${section}
.PATH.${section}:	${DIRS}
.endfor
.endif

.if defined(_MAN_AUTO)
.for man in ${_MAN_AUTO}
.if exists(${man})&&empty(MAN:M${man})
MAN+=			${man}
.endif
.endfor
.endif

.if defined(MANFILTER)
MANTOOL?=		( ${MANFILTER} | ${MANCOMPRESSCMD} )
.else
MANTOOL?=		${MANCOMPRESSCMD}
.endif

do-build:		buildman
buildman:		.PHONY

.if defined(MAN) && !empty(MAN)
.for section in ${MANSECTIONS}
.for man in ${MAN:M*.${section}}
MANDIR.${man:T}=	${MANDIR}/man${section:C@pm$@p@}
.endfor
.endfor

.for man in ${MAN}
CLEANFILES+=		${man}${MANCOMPRESSEXT}
${man}${MANCOMPRESSEXT}: ${man}
	${MANTOOL} < ${.ALLSRC} > ${.TARGET}
buildman: ${man}${MANCOMPRESSEXT}
installfiles-man-${man:T}: ${man}${MANCOMPRESSEXT} .PHONY
	${INSTALL_MAN} ${.ALLSRC} ${DESTDIR}${MANDIR.${man:T}}
.endfor
.endif

.endif #!target(__<bps.man.mk>__)

### End of file `bps.man.mk'
