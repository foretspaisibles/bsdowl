### Makefile -- Prepare an OCaml toplevel

# Author: Michael Grünewald
# Date: Sun Dec 28 18:15:21 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TOPLEVEL=		custom_toplevel

EXTERNAL+=		ocaml.findlib:compiler-libs

SRCS=			custom_configuration.ml
SRCS+=			custom_library.ml
SRCS+=			custom_bootstrap.ml

REPLACESUBST=		${STDREPLACESUBST}
REPLACEFILE=		custom_configuration.ml.in

.include "ocaml.toplevel.mk"

### End of file `Makefile'
