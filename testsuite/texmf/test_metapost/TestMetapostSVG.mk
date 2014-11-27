### TestMetapostSVG.mk -- SVG figures using Metapost

# Author: Michael Grünewald
# Date: Sun Nov 23 19:20:52 CET 2014

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


DOCUMENT=		square.mp
MPDEVICE=		svg

test:
	test -f ${DESTDIR}${DOCDIR}/square-1.svg

.include "mpost.doc.mk"

### End of file `TestMetapostSVG.mk'
