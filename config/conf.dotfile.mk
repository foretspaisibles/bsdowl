### conf.dotfile.mk -- BSD Makefile for dotfiles

# Author: Michael Grünewald
# Date: Tue Sep 12 15:33:20 CEST 2006

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


### SYNOPSIS

# DOTFILE+=		dot.cshrc
# DOTFILE+=		dot.emacs
# DOTFILE+=		dot.gnus
#
# DOTFILEDIR= ${HOME}			# This is the default
# .include "conf.dotfile.mk"


### DESCRIPTION

# Variables:
#
#
#  DOTFILE
#   Enumerate the dotfiles to be installed
#
#
#  DOTFILEDIR [${HOME}]
#   The directory, relative to ${DESTDIR}, for items of DOTFILE


THISMODULE=		conf.dotfile

USE_SWITCH_CREDENTIALS=no

.include "bps.init.mk"

FILESGROUPS+=		DOTFILE
DOTFILEDIR?=		${HOME}

.for item in ${DOTFILE}
.if !defined(DOTFILENAME.${item:T})
DOTFILENAME.${item:T}=	${item:C@^dot@@}
.endif
.endfor

.for filesgroup in ${FILESGROUPS}
_M4_CANDIDATE+=		${${filesgroup}}
.endfor

.include "bps.m4.mk"
.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `conf.dotfile.mk'
