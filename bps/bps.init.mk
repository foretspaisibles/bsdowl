### bps.init.mk -- Initialisation

# Author: Michael Grünewald
# Date: Fri Feb 10 10:40:49 GMT 2006

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


### SYNOPSIS

# .include "bps.init.mk"


# Variables:
#
#  MAKEINITRC [Makefile.inc]
#    The name of a file sitting in SRCDIR which might be included
#
#
#  _BPS_PACKAGEDIR [/bsdowl]
#    A path element identifying our package.
#
#
#  prefix, exec_prefix, datarootdir, bindir, sbindir, libexecdir,
#  datadir, sysconfdir, sharedstatedir, localstatedir, runstatedir
#  includedir, docdir, htmdir, dvidir, pdfdir, psdir, djvudir,
#  infodir, libdir, localedir, mandir
#    Directory variables.
#
#    All these directory variables receive default values based on the
#    installation prefix used by bsdowl.  These variables can however
#    easily be set in ${SRCDIR}/Makefile.inc by your configuration
#    procedure.
#
#
#  DESTDIR [not set]
#    A directory to prepend to PREFIX, only when copying files.
#
#
#  PREFIX [${prefix}]
#    The installation prefix of the package.
#
#    Ususally `/usr /usr/local`, `/opt/local` or `/home/joeuser`.  It
#    must be set at configuration time.
#
#
#  ID [configured value]
#    The command used to query the user database.
#
#
#  UID [$(id -u)]
#    The uid of the current user.
#
#
#  USER [$(id -n -u)]
#    The symbolic name of the current user.
#
#
#  GROUP [$(id -n -g)]
#    The symbolic group of the current user.
#
#
#  ENVTOOL [env]
#    The command used to run a program in a custom environment.
#
#
#  CP [cp]
#    The command used to copy files.
#
#
#  RM [rm]
#    The command used to remove files.
#
#
#  MV [mv]
#    The command used to rename files.
#
#
#  LN_S [${_BPS_LN_S}]
#    The command used to create symbolic links.
#
#
#  MKDIR [mkdir]
#    The command used to create directories.
#
#
#  MKDIR_P [${_BPS_MKDIR_P}]
#    The command used to create paths.
#
#
#  TAR [tar]
#    The tape archiver.
#
#
#  INSTALL [${_BPS_INSTALL}]
#    The BSD-install-like command used to install files.
#
#
#  INSTALL_DIR [${INSTALL} -d]
#    The variant of install used to create directories.
#
#
#  AWK [${_BPS_AWK}]
#    An awk programm.
#
#
#  GREP [${_BPS_GREP}]
#    A grep programm.
#
#
#  SED [${_BPS_SED}]
#    A sed programm.
#
#
#  SED_INPLACE [${SED} -i.orig]
#    The sed command used for inplace edition.
#
#
#  TOUCH [touch]
#    A touch command.
#
#
#  ECHO [echo]
#    An echo program.
#
#
#  INFO [@echo '===>']
#    The command used to output information messages.
#
#
#  WARN [@>&2 echo 'Warning:']
#    The command used to output warning messages.
#
#
#  FAIL [@>&2 echo 'Failure:']
#    The command used to output failure messages.
#
#
#  MESG [@echo]
#    The command used to display random messages.
#
#
#  NOP [@: do nada]
#    A command that does nothinf, a no-op.
#
#
#  SU [su]
#    The command used to gain administrator credentials.
#
#
#  SUDO [sudo]
#    The sudo command used to gain administrator credentials.
#
#
#  SH [/bin/sh]
#    The path to the bourne shell.
#
#  CHOWN [chown]
#    The command to change ownerhsip of files.
#
#
#  CHMOD [chmod]
#    The command to change access mode of files.
#
#
#  FIND [find]
#    The command used to find files matching criterias.
#
#
#  CPIO [cpio]
#    The command used to copy file trees.
#
#
#  M4 [m4]
#   The command used to invoke the macro processor M4
#
#
#  RELDIR [automatically set]
#   The current path, relative to ${SRCDIR}
#
#   This is left undefined if SRCDIR is not defined or if it matches
#   .CURDIR.
#
#
#  _MAKE_USERTARGET [obj configure depend build doc all
#    install test clean distclean realclean benchmark]
#    The list of targets that are defined by every module.
#
#
#  _MAKE_ALLSUBTARGET [configure depend build doc test]
#    The list of subtargets of the all target.


### IMPLEMENTATION

.if !target(__<bps.init.mk>__)
__<bps.init.mk>__:

.sinclude "bps.bpsconfig.mk"

.MAIN:			all

MAKEINITRC?=		Makefile.inc

# Input the package configuration file, if any.
.if defined(SRCDIR) && !empty(SRCDIR)
.sinclude "${SRCDIR}/Makefile.local"
.sinclude "${SRCDIR}/Makefile.config"
.if ${SRCDIR} != ${.CURDIR}
RELDIR:=		${.CURDIR:S@^${SRCDIR}@@}
.sinclude "${SRCDIR}/${MAKEINITRC}"
.endif
.else
.sinclude "Makefile.local"
.sinclude "Makefile.config"
.endif

# Input the current module configuration file, if any.
.sinclude "${.CURDIR}/${MAKEINITRC}"


#
# Directory variables
#

_BPS_PACKAGEDIR?=	/bsdowl

# The definitions of prefix, exec_prefix and datarootdir are
# mandatory, since they are used in the replacement text of autoconf
# substitution above.

prefix?=		${_BPS_PREFIX}
exec_prefix?=		${_BPS_EXEC_PREFIX}
datarootdir?=		${_BPS_DATAROOTDIR}

# The definitions of the remaining directory variables used by
# autoconf is useful, so that projects using autoconf and projects not
# using autoconf can use similar initialisation values for their own
# installation directories.  Also, it useful to have these variables
# because both ocaml.lib module and c.lib use the variable LIBDIR
# which should be derived from libdir in different manners.

bindir?=		${exec_prefix}/bin
sbindir?=		${exec_prefix}/sbin
libexecdir?=		${exec_prefix}/libexec
datadir?=		${datarootdir}
sysconfdir?=		${prefix}/etc
sharedstatedir?=	${prefix}/com
localstatedir?=		${prefix}/var
runstatedir?=		${localstatedir}/run
includedir?=		${prefix}/include
docdir?=		${datarootdir}/doc${PACKAGEDIR}
htmdir?=		${docdir}
dvidir?=		${docdir}
pdfdir?=		${docdir}
psdir?=			${docdir}
djvudir?=		${docdir}
infodir?=		${datarootdir}/info
libdir?=		${exec_prefix}/lib
localedir?=		${datarootdir}/locale
mandir?=		${datarootdir}/man

DESTDIR?=
PREFIX?=		${prefix}


#
# Pseudo-commands
#

ID?=			${_BPS_ID}
ENVTOOL?=		env
CP?=			cp
RM?=			rm
MV?=			mv
LN_S?=			${_BPS_LN_S}
MKDIR?=			mkdir
MKDIR_P?=		${_BPS_MKDIR_P}
TAR?=			tar
INSTALL?=		${_BPS_INSTALL}
INSTALL_DIR?=		${INSTALL} -d
AWK?=			${_BPS_AWK}
GREP?=			${_BPS_GREP}
SED?=			${_BPS_SED}
SED_INPLACE?=		${SED} -i.orig
TOUCH?=			touch
ECHO?=			echo
INFO?=			@echo '===>'
WARN?=			@>&2 echo 'Warning:'
FAIL?=			@>&2 echo 'Failure:'
MESG?=			@echo
NOP?=			@: do nada
SU?=			su
SUDO?=			sudo
SH?=			sh
CHOWN?=			chown
CHMOD?=			chmod
FIND?=			find
CPIO?=			cpio
M4?=			m4


#
# Identify user running make
#

.if target(__<bps.bpsconfig.mk>__)
.if !defined(UID)
UID!=			${ID} -u
.endif

.if !defined(USER)
USER!=			${ID} -n -u
.endif

.if !defined(GROUP)
GROUP!=			${ID} -n -g
.endif
.else
UID=			0
USER=			0
GROUP=			0
.endif


#
# Prefix used for cookies
#

COOKIEPREFIX?=		.cookie.


#
# Set _MAKE_USERTARGET and _MAKE_ALLSUBTARGET
#

_MAKE_USERTARGET?=	obj runconfigure depend build doc all install\
			test clean distclean realclean benchmark preparatives

_SUBDIR_TARGET?=	obj depend build doc install clean distclean realclean test

_MAKE_ALLSUBTARGET?=	depend build doc

#
# Read other definitions
#

.include "bps.package.mk"
.include "bps.architecture.mk"
.include "bps.configuration.mk"
.include "bps.uses.mk"
.include "bps.module.mk"
.include "bps.external.mk"
.include "bps.product.mk"
.include "bps.own.mk"
.include "bps.objdir.mk"
.include "bps.autoconf.mk"
.include "bps.preparatives.mk"
.include "bps.replace.mk"
.include "bps.credentials.mk"
.include "bps.noweb.mk"
.include "bps.test-expected.mk"

.endif # !target(__<bps.init.mk>__)

### End of file `bps.init.mk'
