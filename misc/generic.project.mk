### generic.project.mk -- Preparation of projects

# Author: Michael Grünewald
# Date: Thu Dec  4 23:17:46 CET 2014

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

# PACKAGE=		heat
# VERSION =		1.1.0
# OFFICER=		release-engineer@heat.org
#
# MODULE=		langc.lib:librational
# MODULE+=		langc.lib:libfibonacci
# MODULE+=		langc.prog:heat
#
# .include "bps.project.mk"


### DESCRIPTION

# This maintenance module for software projects should be the “master”
# Makefile of a package source tree.
#
# Beyond supporting the build and test of the software project, it
# also supports other functions like linting or the production of
# GPG-signed tarballs, and the preparation of a developper's subshell.


# Variables:
#
#
#  SRCDIR, WRKDIR, PACKAGE, PACKAGEDIR, VERSION, OFFICER, MODULE, EXTERNAL
#   See bps.package.mk
#
#
#  DISTDIR [${.OBJDIR}]
#   The folder used to publish distribution files and signatures
#
#   A useful value could be 'DISTDIR=${HOME}/Distfiles/${PACKAGE}/${VERSION}'.
#   It can be set from the environment but special care has to be
#   taken to prevent the expansion of ${PACKAGE} and ${VERSION} by
#   the shell.
#
#
#  DISTNAME [${PACKAGENAME}-${VERSION}]
#   The name used to produce tarballs
#
#   This name is also the name of the root directory appearing at the
#   root of the archive.
#
#
#  DISTSIGN
#   The list of extra distribution files which should be signed
#
#
#  DISTNOSIGN
#   The list of extra distribution files which do not need to be signed
#
#
#  DISTEXCLUDE [set by a strategy]
#   The list of files or directories which should not be distributed
#
#   The files enumerated by the DISTEXCLUDE variable are excluded from
#   the tarball distribution. The list of files produced by autoconf
#   is automatically added to this list.
#
#
#  PROJECTENV
#   The list of variables passed to the environment of subshells
#
#
#  PROJECTLIBRARY [Library]
#   The folder used as project library
#
#
#  PROJECTLIBRARYMAKE [Library/Make]
#   The folder holding project specific makefiles
#
#
#  PROJECTLIBRARYSHELL [Library/Ancillary]
#   The folder holding project specific scripts
#
#
#  SUBSHELLDIR [not set]
#   A folder to change to before popping up a subshell


# Targets:
#
#  Each target has the classical decomposition “pre-do-post” which
#  eases their customisation.
#
#
#  dist
#   Create, sign and publish distribution files
#
#    Important note fot GNU tar users: The GNU tar command does not
#    have an option “dereference symbolic links provided on the
#    command line”.  It is therefore forbidden to use symbolic links in
#    the source tree of a project.
#
#
#  subshell
#   Pop up a user subshell


### IMPLEMENTATION

.if defined(MODULE)
_SUBDIR_LIST+=		${MODULE:C@.*\:@@}
.endif

.if defined(SUBDIR)
_SUBDIR_LIST+=		${SUBDIR}
.endif

.include "bps.init.mk"
.include "bps.project.mk"
.include "bps.credentials.mk"
.include "bps.subdir.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

obj: do-obj-subdir

### End of file `generic.project.mk'
