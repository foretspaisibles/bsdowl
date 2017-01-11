### elisp.lib.mk -- Manage Emacs Lisp Directories

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


### SYNOPSIS

# LIBRARY=libraryname
#
# SRCS+= module1.el
# SRCS+= module2.el
#
# .include "elisp.lib.mk"


### DESCRIPTION

# Variables:
#
#  LIBRARY [not set]
#   Name of the library
#
#
#  SRCS [not set]
#    Files that must be compiled for the library
#
#    Listed source files will be installed.
#
#
#  ELISPOWN, ELISPGRP, ELISPMODE, ELISPDIR, ELISPNAME
#   Parameters of the library installation
#
#   See `bps.files.mk` for a closer description of these variables.
#
#
#  ELISPROOTDIR
#   Root of the elisp library heirarchy
#
#   This can be used to customize ELISPDIR, as in
#   ELISPDIR=${ELISPROOTDIR}/${LIBRARY} for instance.

THISMODULE=		elisp.lib

.if !defined(LIBRARY)||empty(LIBRARY)
.error The elisp.lib.mk module expects you to set the LIBRARY variable to a sensible value.
.endif

PRODUCT=		${LIBRARY}
_PACKAGE_CANDIDATE=	${LIBRARY}

FILESGROUPS+=		ELISP

_ELISP_CODE='(progn\
(defun bsdowl-dest-file-function (filename)\
  (let ((pwd (expand-file-name "."))\
        (basename (replace-regexp-in-string ".*/" "" filename)))\
    (concat (file-name-as-directory pwd) basename "c")))\
(setq byte-compile-dest-file-function (quote bsdowl-dest-file-function))\
(batch-byte-compile))'

EMACS?=			${_BPS_EMACS}
ELISPDIR?=		${datarootdir}/emacs/site-lisp
ELISPC?=		${EMACS} -batch --eval ${_ELISP_CODE}

OBJS=			${SRCS:M*.el:.el=.elc}

ELISP+=			${SRCS}
ELISP+=			${OBJS}

CLEANFILES+=		${OBJS}

.SUFFIXES: .el .elc

${OBJS:M*.elc}: ${SRCS:M*.el}
	${ELISPC} ${.ALLSRC}

.el.elc:
	${ELISPC} ${.ALLSRC}

.include "bps.init.mk"
.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `elisp.lib.mk'
