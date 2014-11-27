### TestDraft.mk -- Test draft support

# Author: Michael Grünewald
# Date: Thu Nov 27 22:24:57 CET 2014

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

DOCUMENT=		simple.tex
TEXDEVICE=		pdf
USES+=			draft:git

test:
	test -f ${DESTDIR}${DOCDIR}/simple_*.pdf

.include "latex.doc.mk"

### End of file `TestDraft.mk'
