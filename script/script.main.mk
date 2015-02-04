### script.main.mk -- Development of shell scripts

# Author: Michael Grünewald
# Date: Fri Feb 10 10:40:49 GMT 2006

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

# SCRIPT=		mp2eps.sh
# SCRIPT+=		mp2pdf.sh
# SCRIPT+=		mp2png.sh
#
# SCRIPTLIB+=		mp2pnglib.sh
#
#
# TMPDIR=		/var/run/tmp
#
# REPLACE=		PREFIX TMPDIR
#
# .include "script.main.mk"


### DESCRIPTION

# This module handles the configuration and installation of
# scripts.  The target language is the Bourne shell but other
# scripting languages are supported as well.


# Scripts and Libraries:
#
# We consider two groups of files: script programs (SCRIPT) and script
# libraries (SCRIPTLIB).


# Configuration:
#
# We support configuration of scripts by allowing replacement
# of some fixed strings in the file.  This completes the similar
# feature of `autoconf`.  This replacement is only performed in
# script programs and not in script libraries.


# Variables:
#
#  PROGRAM
#   List of script programs to install
#
#   If a file in this list has a name ending in one of the
#   suffixes enumerated in _SCRIPT_SUFFIXES, then variable replacement
#   may occur in this file, and the file is always installed under a
#   name without the suffix.
#
#
#  SUBR
#   List of script subroutine libraries to install
#
#
#  SUBRDIR [${SHAREDIR}${PACKAGEDIR}]
#   List of script libraries to install
#
#   The variables SUBRDIR, SUBRMODE, SUBROWN and
#   SUBRGRP parametrise the installation.
#
#   The SUBRDIR variable defaults to
#   `${SHAREDIR}${PACKAGEDIR}` but other sensible locations could
#   be `${LIBDIR}/perl5/5.12.4${PACKAGEDIR}`.
#
#
#  REPLACE [not set]
#   List of variables to be replaced in the preparation step
#
#   The pipe character `|` must not appear in replacement text of the
#   variables enumerated by REPLACE.
#
#  STDREPLACE [see description]
#   The standard replacement list


### IMPLEMENTATION

.if !defined(THISMODULE)
.error shell.main.mk cannot be included directly.
.endif

.if !target(__<script.main.mk>__)
__<script.main.mk>__:

.include "bps.init.mk"


#
# Replacement of variables
#

STDREPLACE=		PACKAGE
STDREPLACE+=		VERSION
STDREPLACE+=		prefix
STDREPLACE+=		exec_prefix
STDREPLACE+=		bindir
STDREPLACE+=		sbindir
STDREPLACE+=		libexecdir
STDREPLACE+=		datarootdir
STDREPLACE+=		datadir
STDREPLACE+=		sysconfdir
STDREPLACE+=		sharedstatedir
STDREPLACE+=		localstatedir
STDREPLACE+=		runstatedir
STDREPLACE+=		includedir
STDREPLACE+=		docdir
STDREPLACE+=		infodir
STDREPLACE+=		libdir
STDREPLACE+=		localedir
STDREPLACE+=		mandir

.if defined(REPLACE)&&!empty(REPLACE)
.for var in ${REPLACE}
_SCRIPT_SED+=		-e 's|@${var}@|${${var:S/|/\|/g}}|g'
.endfor
.endif


#
# Script programs
#

_SCRIPT_SUFFIXES?=	sh bash csh ksh sed awk pl py

.if defined(PROGRAM)&&!empty(PROGRAM)
BIN+=			${PROGRAM:C@\.(sh|bash|csh|ksh|awk|sed|pl|py)$@@}
.endif

.for ext in ${_SCRIPT_SUFFIXES}
.for script in ${PROGRAM:M*.${ext}}
CLEANFILES+=		${script:T:.${ext}=}
buildfiles:		${script:T:.${ext}=}
.if defined(_SCRIPT_SED)
${script:T:.${ext}=}: ${script}
	${SED} ${_SCRIPT_SED} < ${.ALLSRC} > ${.TARGET}.output
	${MV} ${.TARGET}.output ${.TARGET}
.else
${script:T:.${ext}=}: ${script}
	${CP} ${.ALLSRC} ${.TARGET}
.endif
.endfor
.endfor


#
# Script subroutine libraries
#

# Script subroutines are not preprocessed.

.if defined(LIBRARY)&&!empty(LIBRARY)
SUBR+=			${LIBRARY}
.endif

SUBRMODE?=		${SHAREMODE}
SUBRDIR?=		${SHAREDIR}
SUBROWN?=		${SHAREOWN}
SUBRGRP?=		${SHAREGRP}

FILESGROUPS+=		SUBR


#
# Maybe filter manual pages
#

.if defined(_SCRIPT_SED)&&!defined(MANFILTER)
MANFILTER=		${SED} ${_SCRIPT_SED}
.endif


.include "bps.man.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

.endif #!target(__<script.main.mk>__)

### End of file `script.main.mk'
