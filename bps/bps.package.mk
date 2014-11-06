### bps.package.mk -- Package description and targets

# Author: Michael Grünewald
# Date: Wed Nov  5 15:30:29 CET 2014

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

# This file manages variables carrying package information.


### VARIABLES

# SRCDIR [${.CURDIR:T}, inherited]
#  The root of the source-tree of our package.
#
# PACKAGE [last component of SRCDIR, inherited]
#  The name of our package.
#
#   This name should be a valid Unix identifier, without spaces. If
#   it is not set, the last component of SRCDIR is used for this.
#
# PACKAGEDIR [/${PACKAGE}, inherited]
#  A path element which can be used to build paths specific to our package.
#
# VERSION [0.1.0-current, inherited]
#  The version of our package.
#
# OFFICER [${EMAIL} or ${USER}@${HOST}, inherited]
#  The release engineering officer.
#
#   This identifies the GPG key used to sign tarballs and other
#   distributed files.
#
# MODULE [not set]
#  The list of modules belonging to the package.
#
#   The list consists of pairs `module:path` where `module` is a BSD Owl
#   module like `ocaml.prog` or `latex.doc` or `c.lib` and path is the
#   path to the directory corresponding to the module with respect to
#   `${SRCDIR}`, the root of our source tree.
#
# EXTERNAL [not set]
#  The list of external dependencies of the package.
#
#  The list consists of pair `consumer:resource` where `consumer` is a
#  keyword identifying the type of the external resource and `resource`
#  is its symbolic name.

.if !target(__<bps.init.mk>__)
.error bps.package.mk cannot be included directly.
.endif

.if !target(__<bps.package.mk>__)&&!defined(SRCDIR)
__<bps.package.mk>__:

SRCDIR:=		${.CURDIR}

.if !defined(PACKAGE)
PACKAGE=		${SRCDIR:T}
.endif

PACKAGEDIR?=		/${PACKAGE}

VERSION?=		0.1.0-current

.if !defined(OFFICER)
.if defined(EMAIL)&&!empty(EMAIL)
OFFICER=		${EMAIL}
.else
OFFICER=		${USER}@${HOST}
.endif
.endif

MODULE?=
EXTERNAL?=

.export SRCDIR
.export PACKAGE
.export PACKAGEDIR
.export VERSION
.export OFFICER
.export MODULE
.export EXTERNAL

.endif # !target(__<bps.package.mk>__)

.if!target(display-package)
display-package:
	${INFO} 'Display package information'
.for displayvar in PACKAGE PACKAGEDIR VERSION OFFICER SRCDIR MODULE EXTERNAL
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.endif

### End of file `bps.package.mk'
