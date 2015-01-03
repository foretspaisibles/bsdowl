### TestToplevel.mk -- Prepare an OCaml toplevel

# Author: Michael Grünewald
# Date: Sun Dec 28 18:15:21 CET 2014

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

TOPLEVEL=		custom_toplevel

EXTERNAL+=		ocaml.findlib:compiler-libs

SRCS=			custom_configuration.ml
SRCS+=			custom_library.ml
SRCS+=			custom_bootstrap.ml

REPLACESUBST=		${STDREPLACESUBST}
REPLACEFILE=		custom_configuration.ml.in

test:
	test -x ${DESTDIR}${BINDIR}/custom_toplevel

.include "ocaml.toplevel.mk"

### End of file `TestToplevel.mk'
