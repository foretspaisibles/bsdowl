### Makefile -- A complex heat generating program

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

PACKAGE=	goldenratio
VERSION=	0.0.1-current
OFFICER?=	michipili@gmail.com

MODULE=		langc++.lib:librational++
MODULE+=	langc.prog:src

do-configure:
	(cd ${.CURDIR} && autoconf && ./configure)

runtest: src/goldenratio
	${.ALLSRC:tA}

.include "generic.project.mk"

### End of file `Makefile'
