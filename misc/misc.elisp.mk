### misc.elisp.mk -- Manage Emacs Lisp Directories

# Author: Michaël Le Barbier
# Date: Fri Feb 10 17:59:16 2006
# Lang: fr_FR.ISO8859-15

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

# SRCS+= module1.el
# SRCS+= module2.el
#
# ELISPC.module1.elc = A command to compile my elisp thing
# ELISPMODE.module2.elc = 400
#
# ELISP_INSTALL_SRC.module2.el = no
#
# .include "misc.elisp.mk"


### DESCRIPTION

# Ce module compile et installe des modules EMACS LISP. Le répertoire
# d'installation est déterminé par la valeur de ELISPDIR
# (/share/emacs/site-lisp).
#
# La variable ELISP_INSTALL_SRC (yes) contrôle l'installation des
# fichiers source avec les fichiers byte-code.

FILESGROUPS+= ELISP
ELISP_INSTALL_SRC = yes

ELISPDIR?= ${PREFIX}/share/emacs/site-lisp
ELISPC?= emacs -batch -f batch-byte-compile

.if defined (SRCS) && !empty(SRCS:M*.el)

ELISP+=		${SRCS:M*.el:.el=.elc}

.for file in ${SRCS:M*.el}

#
# Installation des fichiers sources
#

.if !defined(ELISP_INSTALL_SRC.${file})
ELISP_INSTALL_SRC.${file}=${ELISP_INSTALL_SRC}
.endif

.if ${ELISP_INSTALL_SRC.${file}} == yes
ELISP+=${file}
.endif
.endfor


.for obj in ${SRCS:M*.el:.el=.elc}

#
# Fichiers à nettoyer
#

CLEANFILES+= ${obj}

#
# Calcul de la ligne de compilation
#

.if !defined(ELISPC.${obj})
ELISPC.${obj} = ${ELISPC}
.endif

${obj}: ${obj:.elc=.el}
	${ELISPC.${obj}} ${.ALLSRC}


.endfor

.endif

.include "make.init.mk"
.include "make.clean.mk"
.include "make.files.mk"
.include "make.usertarget.mk"

### End of file `misc.elisp.mk'
