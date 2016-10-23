### bps.architecture.mk -- Handle architecture information

# Author: Michael Grünewald
# Date: Wed Nov  5 16:48:35 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


### DESCRIPTION

# Handle architecture information and configuration files.  If a
# package has configuration settings dependant of the architecure, it
# should define ARCHITECTURE_AVAILABLE the list of supported
# architectures and set ARCHITECTURE to one element of this list.

# Variables:
#
#  ARCHITECTURE [not set]
#    A string identifying the architecture for which the project is built.
#
#    If this variable is set, we try to read the file
#    ${PACKAGELIBRARYARCHITECTURE}/${ARCHITECTURE}.mk and issue an error
#    if the file cannot be read.
#
#
#  ARCHITECTUREDIR [/${ARCHITECTURE}, only if ARCHITECTURE is set]
#    A path element used to build a directory name dependant of architecture.
#
#
#  ARCHITECTURE_AVAILABLE [${ARCHITECTURE}, only if ARCHITECTURE is set]
#    The list of available architectures.
#
#
#  PACKAGELIBRARYARCHITECTURE [${SRCDIR}/Library/Configuration]
#    A directory where architecture configuration files are stored.

.if !target(__<bps.init.mk>__)
.error bps.architecture.mk cannot be included directly.
.endif

.if !target(__<bps.architecture.mk>__)&&defined(ARCHITECTURE)
__<bps.architecture.mk>__:

PACKAGELIBRARYARCHITECTURE?=	${SRCDIR}/Library/Configuration
ARCHITECTUREDIR?=	/${ARCHITECTURE}
ARCHITECTURE_AVAILABLE?=	${ARCHITECTURE}

.if exists(${PACKAGELIBRARYARCHITECTURE}/${ARCHITECTURE}.mk)
.include "${PACKAGELIBRARYARCHITECTURE}/${ARCHITECTURE}.mk"
.else
.error Nothing is known about architecture ${ARCHITECTURE}.
.endif

.if empty(.MAKE.EXPORTED:MARCHITECTURE)
.export			ARCHITECTURE
.endif

.if empty(.MAKE.EXPORTED:MARCHITECTURE_AVAILABLE)
.export			ARCHITECTURE_AVAILABLE
.endif


.endif # !target(__<bps.architecture.mk>__)

.if!target(display-architecture)
display-architecture:
	${INFO} 'Display architecture information'
.for displayvar in ARCHITECTURE ARCHITECTUREDIR PACKAGELIBRARYARCHITECTURE
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.endif

### End of file `bps.architecture.mk'
