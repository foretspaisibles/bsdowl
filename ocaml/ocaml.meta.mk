### ocaml.meta.mk -- Installation of META files

# Author: Michael Grünewald
# Date: Wed Jun 30 16:02:10 CEST 2010

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

# LIBDIR?=		${PREFIX}/lib/ocaml/site-lib${PACKAGEDIR}
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

.if exists(META)||exists(META.in)
META=			META
.endif

.if ${THISMODULE} == ocaml.meta
.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"
.endif

.endif #!target(__<ocaml.meta.mk>__)

### End of file `ocaml.meta.mk'
