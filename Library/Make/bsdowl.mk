### bsdowl -- Fichier de directives principal

# Author: Michael Grünewald
# Date: Dim 13 avr 2008 23:56:07 CEST
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

# BSD Owl Scripts (https://bitbucket.org/michipili/bsdowl)
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

### DESCRIPTION

.if !target(__<bsdowl>__)
__<bsdowl>__:

.MAKEFLAGS:	-I${.CURDIR}/Library/Make
.for subdir in ${SUBDIR}
.MAKEFLAGS: -I${.CURDIR}/${subdir}
.endfor


.include "subdir.mk"
.include "bps.project.mk"

# We remove pathes matching the installation prefix ${PREFIX} from the
# MAKEFLAGS variable.

.for prefix in ${PREFIX}
_BPS_MAKEFLAGS:=${.MAKEFLAGS:C|-I||:C|^/|-I/|:C|^\.|-I.|:N-I${prefix}*}
.endfor

PROJECTENV:=	${PROJECTENV:NMAKEFLAGS=*} MAKEFLAGS="${_BPS_MAKEFLAGS}"

.endif # !target(__<bsdowl>__)

### End of file `bsdowl'
