### Makefile.inc -- Configuration for samhain project

# Author: Michael Grünewald
# Date: Fri Nov 28 10:07:22 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TEXDEVICE=		pdf dvi ps
.PATH:			${SRCDIR}/src

FILESDIR=		${datarootdir}/texmf-local/tex/latex${PACKAGEDIR}
DOCDIR=			${datarootdir}/texmf-local/doc/latex${PACKAGEDIR}

### End of file `Makefile.inc'
