### TestPack.mk -- Produce a packed library

# Author: Michael Grünewald
# Date: Sat Nov 29 08:06:59 CET 2014

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

PACK=			minibasic

SRCS=			basic_types.ml
SRCS+=			basic_parser.mly
SRCS+=			basic_lexer.mll

.PATH:			${BSDOWLSRCDIR}/example/ocaml/minibasic

test:
	test -f ${DESTDIR}${LIBDIR}/minibasic.cma
	test -f ${DESTDIR}${LIBDIR}/minibasic.cmi

.include "ocaml.pack.mk"

### End of file `TestPack.mk'
