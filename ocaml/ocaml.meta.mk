### ocaml.meta.mk -- Installation of META files

# Author: Michael Grünewald
# Date: Wed Jun 30 16:02:10 CEST 2010

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


### SYNOPSIS

# LIBDIR?=		${ocamllibdir}${PACKAGEDIR}
# .include "ocaml.meta.mk"


### DESCRIPTION

# This module defines a file group for the installation of a META
# file.  It recognises both a META and a META.in file and register the
# META file for installation.


.if !target(__<ocaml.meta.mk>__)
__<ocaml.meta.mk>__:

THISMODULE?=		ocaml.meta

.if ${THISMODULE} == ocaml.meta
PRODUCT=		${META}
.endif

.include "ocaml.init.mk"

FILESGROUPS+=		META

METAOWN?=		${LIBOWN}
METAGRP?=		${LIBGRP}
METADIR?=		${LIBDIR}
METAMODE?=		${LIBMODE}
METANAME?=		META

STDREPLACE=		PACKAGE
STDREPLACE+=		VERSION
STDREPLACE+=		prefix
STDREPLACE+=		exec_prefix
STDREPLACE+=		bindir
STDREPLACE+=		sbindir
STDREPLACE+=		libexecdir
STDREPLACE+=		datarootdir
STDREPLACE+=		datadir
STDREPLACE+=		sysconfdir
STDREPLACE+=		sharedstatedir
STDREPLACE+=		localstatedir
STDREPLACE+=		runstatedir
STDREPLACE+=		includedir
STDREPLACE+=		docdir
STDREPLACE+=		infodir
STDREPLACE+=		libdir
STDREPLACE+=		ocamllibdir
STDREPLACE+=		localedir
STDREPLACE+=		mandir

REPLACE+=		${STDREPLACE}

_SCRIPT_SED=		${SED}

.if defined(REPLACE)&&!empty(REPLACE)
.for var in ${REPLACE}
_SCRIPT_SED+=		-e 's|@${var}@|${${var:S/|/\|/g}}|g'
.endfor
.endif

.if exists(META)||exists(META.in)
META=			META
.endif

.if !empty(META)
.for file in ${META}
.if exists(${file}.in)
${file}:		${file}.in
	${_SCRIPT_SED} ${.ALLSRC} > ${.TARGET}
CLEANFILES+=		${file}
.endif
.endfor
.endif

.if ${THISMODULE} == ocaml.meta
.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"
.endif

.endif #!target(__<ocaml.meta.mk>__)

### End of file `ocaml.meta.mk'
