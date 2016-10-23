### Makefile -- A complex heat generating program

# Author: Michael Grünewald
# Date: Fri Nov 14 10:56:08 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

PACKAGE=	heat
VERSION=	0.1-current
OFFICER?=	michipili@gmail.com

MODULE=		langc.lib:librational
MODULE+=	langc.lib:libfibonacci
MODULE+=	langc.prog:goldenratio

do-configure:
	(cd ${.CURDIR} && autoconf && ./configure)

do-test: goldenratio/goldenratio
	${.ALLSRC:tA}

.include "generic.project.mk"

### End of file `Makefile'
