### TestIndex.mk -- Test index support

# Author: Michael Grünewald
# Date: Thu Nov 27 12:27:35 CET 2014

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

DOCUMENT=		withindex.tex
TEXDEVICE=		pdf
USES+=			index

test:
	test -f ${DESTDIR}${DOCDIR}/withindex.pdf

.include "latex.doc.mk"

### End of file `TestIndex.mk'
