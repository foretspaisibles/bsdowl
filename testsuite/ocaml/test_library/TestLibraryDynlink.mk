### TestLibraryDynlink.mk -- Produce a simple library and install with findlib

# Author: Michael Grünewald
# Date: Sun Nov 30 12:18:24 CET 2014

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

LIBRARY=		newton

SRCS=			newton.ml

USES+=			site-lib
USES+=			dynlink

COMPILE=		native

.PATH:			${TESTSRCDIR}/ocaml/newton
.PATH:			${TESTSRCDIR}/ocaml/newton-meta

test:
	test -f ${DESTDIR}${LIBDIR}/newton.cmxa
	test -f ${DESTDIR}${LIBDIR}/newton.cmxs
	test -f ${DESTDIR}${LIBDIR}/newton.cmi
	test -f ${DESTDIR}${LIBDIR}/META

.include "ocaml.lib.mk"

### End of file `TestLibraryDynlink.mk'
