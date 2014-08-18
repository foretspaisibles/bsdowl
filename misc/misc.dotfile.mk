### misc.dotfile.mk -- BSD Makefile for dotfiles

# Author: Michael Grünewald
# Date: Tue Sep 12 15:33:20 CEST 2006
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

# BSD Owl Scripts (https://bitbucket.org/michipili/bsdowl)
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

# DOTFILE+= dot.cshrc
# DOTFILE+= dot.emacs
# DOTFILE+= dot.gnus
#
# DOTFILEDIR = ${HOME}			# This is the default
# .include "misc.dotfile.mk"


### DESCRIPTION

# Install dotfiles.

FILESGROUPS+= DOTFILE
DOTFILEDIR?= ${HOME}

.for item in ${DOTFILE}
.if !defined(DOTFILENAME.${item:T})
DOTFILENAME.${item:T}=${item:C/^dot//}
.endif
.endfor

USE_SWITCH_CREDENTIALS=no

.include "bps.init.mk"
.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `misc.dotfile.mk'
