### bps.replace.mk -- Replace configuration variables

# Author: Michael Grünewald
# Date: Sat Jan  3 13:08:29 CET 2015

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2015 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# REPLACESUBST=		${STDSUBST}
# REPLACESUBST+=	VARIABLE1
# REPLACESUBST+=	VARIABLE2
#
# REPLACEFILE+=		configuration_values.in


### DESCRIPTION

# Substitute placeholders of the form @variable@ with the expansion of
# variable.  This mechanism can be used to replace configuration
# variables, typically listed in the Makefile.config file of the
# project.

# Variables:
#
#  REPLACESUBST [not set]
#   The list of variable to replace
#
#
#  STDREPLACESUBST [a long list of typical autoconf variables]
#   A pre-made list that can be added to REPLACESUBST
#
#
#  REPLACEFILTER [set by initialisation strategy]
#   A filter performing the replacement
#
#   If REPLACESUBST is not set or empty, then REPLACEFILTER remains
#   undefined.
#
#
#  REPLACEFILE [not set]
#   The list of file where substitutions are to be performed
#
#   Each file in the list is subject to replacement.  These files must
#   have a name ending in .in, which is removed in the replaced file.


.if !target(__<bps.init.mk>__)
.error bps.replace.mk cannot be included directly.
.endif

.if !target(__<bps.replace.mk>__)
__<bps.replace.mk>__:

STDREPLACESUBST=	PACKAGE
STDREPLACESUBST+=	VERSION
STDREPLACESUBST+=	prefix
STDREPLACESUBST+=	exec_prefix
STDREPLACESUBST+=	bindir
STDREPLACESUBST+=	sbindir
STDREPLACESUBST+=	libexecdir
STDREPLACESUBST+=	datarootdir
STDREPLACESUBST+=	datadir
STDREPLACESUBST+=	sysconfdir
STDREPLACESUBST+=	sharedstatedir
STDREPLACESUBST+=	localstatedir
STDREPLACESUBST+=	runstatedir
STDREPLACESUBST+=	includedir
STDREPLACESUBST+=	docdir
STDREPLACESUBST+=	infodir
STDREPLACESUBST+=	libdir
STDREPLACESUBST+=	localedir
STDREPLACESUBST+=	mandir

.if defined(REPLACESUBST)&&!empty(REPLACESUBST)
.for var in ${REPLACESUBST}
_REPLACE_SED_SCRIPT+=	-e 's|@${var}@|${${var:S/|/\|/g}}|g'
.endfor
REPLACEFILTER?=		${SED} ${_REPLACE_SED_SCRIPT}
.endif

.if defined(REPLACEFILE)&&!empty(REPLACEFILE)
.if !empty(REPLACEFILE:N*.in)
.error Cannot process files ${REPLACEFILE:N*.in} in REPLACEFILE.
.endif
.for file in ${REPLACEFILE}
${file:.in=}: ${file}
	${REPLACEFILTER} < ${.ALLSRC} > ${.TARGET}
DISTCLEANFILES+=	${file:.in=}
.endfor
.endif

.endif # !target(__<bps.replace.mk>__)

### End of file `bps.replace.mk'
