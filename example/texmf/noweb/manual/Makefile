### Makefile -- Prepare manual for Samhain LaTeX

# Author: Michael Grünewald
# Date: Fri Nov 28 11:19:47 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

DOCUMENT=		shusermanual

NOWEB=			shltxbegin.nw
NOWEB+=			shltx.nw
NOWEB+=			shclasses.nw
NOWEB+=			shmetal.nw
NOWEB+=			shpaper.nw
NOWEB+=			shplexos.nw
NOWEB+=			shthm.nw
NOWEB+=			shltxend.nw

NOWEAVE=		${DOCUMENT}
SRCS=			shusermanual.tex

USES+=			noweb
NOWEAVE_LATEX_WRAPPER=	delay
NOWEAVE_LATEX_DEFS=	l2h.in

.include "latex.doc.mk"

### End of file `Makefile'
