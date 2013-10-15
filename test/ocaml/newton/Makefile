### Makefile -- Newton's method

# Author: Michael Grünewald
# Date: Thu Oct  3 23:39:20 CEST 2013

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

LIBRARY=	newton
SRCS+=		newton.ml

test: newton.cma .PHONY
	ocaml newton.cma test_newton.ml

.include "ocaml.lib.mk"

### End of file `Makefile'
