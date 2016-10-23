### Makefile -- Test draft support

# Author: Michael Grünewald
# Date: Thu Nov 27 22:24:57 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

DOCUMENT=		galley.tex
USES+=			draft:git

.if !defined(TEXDRAFTSTAMP)
TEXDRAFTSTAMP_CMD=	git log -1 --pretty=tformat:'%ai %h' | tr ' ' '_'
TEXDRAFTSTAMP!=		(cd ${.CURDIR} && ${TEXDRAFTSTAMP_CMD})
.endif

.include "latex.doc.mk"

### End of file `Makefile'
