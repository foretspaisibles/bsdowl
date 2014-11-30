### TestComplex.mk -- Mini project

# Author: Michael Grünewald
# Date: Sun Oct 13 10:50:45 CEST 2013

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

PACKAGE=	golden_ratio
VERSION=	1.0.0
OFFICER=	michipili@gmail.com

MODULE=		ocaml.lib:fibonacci
MODULE+=	ocaml.lib:newton
MODULE+=	ocaml.prog:golden_ratio
MODULE+=	ocaml.manual:manual

EXTERNAL+=	ocaml.lib:nums

test-lib:
	test -f ${DESTDIR}${LIBDIR}/fibonacci.cma
	test -f ${DESTDIR}${LIBDIR}/fibonacci.cmi
	test -f ${DESTDIR}${LIBDIR}/newton.cma
	test -f ${DESTDIR}${LIBDIR}/newton.cmi

test-prog:
	test -f ${DESTDIR}${BINDIR}/golden_ratio

test-doc:
	test -f ${DESTDIR}${DOCDIR}/html/index.html

test:	test-lib test-doc test-prog

.include "bps.project.mk"

### End of file `TestComplex.mk'
