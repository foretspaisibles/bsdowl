### misc.dotfile.mk -- BSD Makefile for dotfiles

# Author: Michaël Le Barbier Grünewald
# Date: Tue Sep 12 15:33:20 CEST 2006
# Lang: fr_FR.ISO8859-15

# $Id$

# Copyright (c) 2006, 2007, 2008, 2009 Michaël Le Barbier Grünewald
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

# DOTFILE+= dot.cshrc
# DOTFILE+= dot.emacs
# DOTFILE+= dot.gnus
#
# DOTFILEDIR = ${HOME}			# This is the default
# .include "misc.dotfile.mk"


### DESCRIPTION

# Installe des fichiers `dotfiles' .cshrc, .emacs, .gnus, etc., avec
# comme source des noms visibles dot.cshrc, dot.emacs, dot.gnus, etc.


FILESGROUPS+= DOTFILE
DOTFILEDIR?= ${HOME}

.for item in ${DOTFILE}
.if !defined(DOTFILENAME.${item:T})
DOTFILENAME.${item:T}=${item:C/^dot//}
.endif
.endfor

.include "bps.init.mk"
.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `misc.dotfile.mk'
