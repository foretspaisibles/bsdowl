### Mingw32 -- Mingw32 build settings

# Author: Michael Grünewald
# Date: Sun Nov 16 12:03:36 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

CC=			${MINGW32CC}
AR=			${MINGW32AR}

.if "${THISMODULE}" == "langc.prog"
.for program in ${PROGRAM}
BINNAME.${program:T}=	${program}.exe
.endfor
.endif

### End of file `Mingw32'
