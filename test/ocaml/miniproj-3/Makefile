### Makefile -- Mini project

# Author: Michael Grünewald
# Date: Sun Oct 13 10:50:45 CEST 2013

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

PROJECT=	golden_ratio
VERSION=	1.0
AUTHOR=		Michael Grünewald

SUBDIR+=	fibonacci
SUBDIR+=	newton
SUBDIR+=	golden_ratio
SUBDIR+=	manual

PROJECTSETUP=	debug profile release

universe:
.for setup in ${PROJECTSETUP}
	${ENVTOOL} MAKEINITRC=Makefile.${setup} MAKEOBJDIR=${.CURDIR}/obj/${setup} ${MAKE} all
.endfor

.include "bps.project.mk"

### End of file `Makefile'
