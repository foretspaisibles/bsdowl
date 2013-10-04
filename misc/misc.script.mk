### misc.script.mk -- Development of shell scripts

# Author: Michael Grünewald
# Date: Fri 10 Feb 2006 10:40:49 GMT
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2006-2009, 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# SCRIPT = mp2eps.sh
# SCRIPT+= mp2pdf.sh
# SCRIPT+= mp2png.sh
#
# SCRIPTLIB+= mp2pnglib.sh
#
#
# TMPDIR = /var/run/tmp
#
# REPLACE = PREFIX TMPDIR
#
# .include "misc.script.mk"


### DESCRIPTION

# This modules handles the configuration and installation of
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
# SCRIPT
#   List of script programs to install
#
#   The variables BINDIR, BINMODE, BINOWN and BINGRP
#   parametrise the installation.
#
#
# SCRIPTLIB
#   List of script libraries to install
#
#   The variables SCRIPTLIBDIR, SCRIPTLIBMODE, SCRIPTLIBOWN and
#   SCRIPTLIBGRP parametrise the installation.
#
#   The SCRIPTLIBDIR variable defaults to
#   `${SHAREDIR}${APPLICATIONDIR}` but other sensible locations could
#   be `${LIBDIR}/perl5/5.12.4/${APPLICATIONDIR}`.
#
#
# APPLICATION
#   Name of the application
#
#   It must be a UNIX filename and can be defined to let script
#   libraries be installed in an application specific subdirectory.
#
#
# REPLACE
#   List of variables to be replaced in the configuration step
#
#   The declaration `REPLACE=PREFIX` arranges so that the sequence
#   `@prefix@` is replaced by the value of `PREFIX` known to `make`.
#
#   The case conversion should help to follow the different
#   conventions used when writing makefiles and using autoconf.
#
#   The pipe character `|` must not appear in replacement text of the
#   variables enumerated by REPLACE.


### IMPLEMENTATION

.if !target(__<misc.script.mk>__)
__<misc.script.mk>__:

.include "bps.init.mk"


#
# Replacement of variables
#

.if defined(REPLACE)&&!empty(REPLACE)
.for var in ${REPLACE}
_SCRIPT_SED+= -e 's|@${var:L}@|${${var:S/|/\|/g}}|g'
.endfor
.endif


#
# Script programs
#

_SCRIPT_EXTS?= pl sh bash py sed awk

.for ext in ${_SCRIPT_EXTS}
.for script in ${SCRIPT:M*.${ext}}
BIN+= ${script:T:.${ext}=}
CLEANFILES+= ${script:T:.${ext}=}
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
# Script libraries
#

SCRIPTLIBMODE?= ${SHAREMODE}
SCRIPTLIBDIR?= ${SHAREDIR}
SCRIPTLIBOWN?= ${SHAREOWN}
SCRIPTLIBGRP?= ${SHAREGRP}

FILESGROUPS+= SCRIPTLIB


.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

.endif #!target(__<misc.script.mk>__)

### End of file `misc.script.mk'
