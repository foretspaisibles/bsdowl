### Makefile -- Newton's method

# Author: Michael Grünewald
# Date: Thu Oct  3 23:39:20 CEST 2013

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

LIBRARY=	newton
SRCS+=		newton.ml

do-test: newton.cma test_newton.ml .PHONY
	ocaml ${.ALLSRC}

.include "ocaml.lib.mk"

### End of file `Makefile'
