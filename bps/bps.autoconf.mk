### bps.autoconf.mk -- Support for autoconf

# Author: Michael Grünewald
# Date: Ven Apr 18 2008 09:59:39 CEST

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

# CONFIGURE=		Makefile.in
# CONFIGURE+=		header.in

### DESCRIPTION

# If a file configure.ac or configure.in is found in the root of
# the project tree, or if the variable USE_AUTOCONF is set to yes,
# then intermediary products associated to the files listed in the
# CONFIGURE variable are added to the distclean list.

# Variables:
#
#  USE_AUTOCONF [set by initialisation strategy]
#    Flag controlling the use of bps.autoconf.mk.
#
#    If a file configure.ac or configure.in is found in the root of
#    the project tree, or if the variable USE_AUTOCONF is set to yes.

#  CONFIGURE [set by initialisation strategy]
#    List of files processed for substitution by the configure script.
#
#    The substituted files derived from the original files are added
#    to DISTCLEANFILES.  If found, files Makefile.in and
#    Makefile.inc.in are automatically added to this list.

.if !target(__<bps.init.mk>__)
.error bps.autoconf.mk cannot be included directly.
.endif

.if !target(__<bps.autoconf.mk>__)
__<bps.autoconf.mk>__:

.if exists(configure.ac)||exists(autoconf.in)
USE_AUTOCONF?=yes
.endif
USE_AUTOCONF?=no
.if ${USE_AUTOCONF} == yes
.for file in config.status config.log
.if exists(${file})
DISTCLEANFILES+=	${file}
.endif
.endfor
.if exists(autom4te.cache)
DISTCLEANDIRS+=		autom4te.cache
.endif
.for file in Makefile.in Makefile.inc.in
.if exists(${file})&&empty(CONFIGURE:M${file})
CONFIGURE+=		${file}
.endif
.endfor
REALCLEANFILES+=	${CONFIGURE:.in=}
.if exists(configure.ac)||exists(configure.in)
.if !defined(REALCLEANFILES)||empty(REALCLEANFILES:Mconfigure)
REALCLEANFILES+=	configure
.endif
.endif
.endif # ${USE_AUTOCONF} == yes
.endif # !target(__<bps.autoconf.mk>__)

### End of file `bps.autoconf.mk'
