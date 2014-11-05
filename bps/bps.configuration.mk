### bps.configuration.mk -- Manage package build configurations

# Author: Michael Grünewald
# Date: Wed Nov  5 16:36:22 CET 2014

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


### DESCRIPTION

# Manage package build configurations.

### VARIABLES

# CONFIGURATION [not set]
#  The name of a configuration build file to be read.
#
#   If CONFIGURATION is set, we try to read the file
#   ${CONFIGURATION}.mk and issue an error if this cannot be done.
#   If a file ${CONFIGURATION}_${ARCHITECTURE}.mk also exits, it is
#   also processed.
#
#   The files are to be read from the PACKAGELIBRARYCONFIGURATION
#   directory.
#
# CONFIGURATIONDIR [/${CONFIGURATION} but only if CONFIGURATION is set]
#  A path element used to build a directory name dependant of configuration.
#
# PACKAGELIBRARYCONFIGURATION [${SRCDIR}/Library/Configuration]
#  A directory where configuration files are stored.
#
# ARCHITECTURE [not set]
#  A string identifying the architecture for which the project is built.
#
#   If set, we try to read the file
#   ${CONFIGURATION}_${ARCHITECTURE}.mk, which happens after
#   processing the file ${CONFIGURATION}.mk.
#
#   It is not and error if the file does not exist.

.if !target(__<bps.init.mk>__)
.error bps.configuration.mk cannot be included directly.
.endif

.if !target(__<bps.configuration.mk>__)&&defined(CONFIGURATION)
__<bps.configuration.mk>__:

PACKAGELIBRARYCONFIGURATION?=	${SRCDIR}/Library/Configuration
CONFIGURATIONDIR?=	/${CONFIGURATION}

.if exists(${PACKAGELIBRARYCONFIGURATION}/${CONFIGURATION}.mk)
.include ${PACKAGELIBRARYCONFIGURATION}/${CONFIGURATION}.mk
.else
.error Nothing is known about configuration ${CONFIGURATION}.
.endif

.if defined(ARCHITECTURE)
.if exists(${PACKAGELIBRARYCONFIGURATION}/${CONFIGURATION}_${ARCHITECTURE}.mk)
.include ${PACKAGELIBRARYCONFIGURATION}/${CONFIGURATION}_${ARCHITECTURE}.mk
.endif
.endif

.if empty(.MAKE.EXPORTED:MCONFIGURATION)
.export			CONFIGURATION
.endif

.endif # !target(__<bps.configuration.mk>__)

.if!target(display-configuration)
display-configuration:
	${INFO} 'Display configuration information'
.for displayvar in CONFIGURATION CONFIGURATIONDIR PACKAGELIBRARYCONFIGURATION
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.endif

### End of file `bps.configuration.mk'
