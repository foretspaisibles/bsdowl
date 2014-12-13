### TestPpxDeriving.mk -- Example using PPX deriving

# Author: Michael Grünewald
# Date: Tue Dec  9 23:20:22 CET 2014

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

PROGRAM=	point

SRCS=		point.ml
SRCS+=		main.ml

EXTERNAL=	ocaml.findlib:ppx_deriving
EXTERNAL+=	ocaml.findlib:ppx_deriving.std

test:
	test -x ${DESTDIR}${BINDIR}/point
	${DESTDIR}${BINDIR}/point

.include "ocaml.prog.mk"

### End of file `TestPpxDeriving.mk'
