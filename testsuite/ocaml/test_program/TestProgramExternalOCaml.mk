### TestProgramExternalOCaml.mk -- How does it feel?

# Author: Michael Grünewald
# Date: Fri Jan  9 09:06:51 CET 2015

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

PROGRAM=		rolling_stone
EXTERNAL=		ocaml.lib:unix

_EXTERNAL_ocaml.lib_unix_DIR=	${ocamllibdir}/ocaml
_EXTERNAL_ocaml.lib_unix_BYTE=	unix.cma
_EXTERNAL_ocaml.lib_unix_NATIVE=unix.cmxa

test:
	test -x ${DESTDIR}${BINDIR}/rolling_stone

.PATH:			${BSDOWLSRCDIR}/example/ocaml/rolling_stone

.include "ocaml.prog.mk"

### End of file `TestProgramExternalOCaml.mk'
