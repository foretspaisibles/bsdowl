### Makefile -- Computing the golden ratio

# Author: Michael Grünewald
# Date: Sat Oct  5 20:47:48 CEST 2013

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

PROGRAM=	golden_ratio

SRCS=		main.ml

LIBS+=		nums
LIBS+=		newton
LIBS+=		fibonacci

DIRS=		${.OBJDIR}/../newton
DIRS+=		${.OBJDIR}/../fibonacci

newton.cma:
	@cd ${.CURDIR}/../newton && ${MAKE} ${.TARGET}

fibonacci.cma:
	@cd ${.CURDIR}/../fibonacci && ${MAKE} ${.TARGET}

.include "ocaml.prog.mk"

### End of file `Makefile'
