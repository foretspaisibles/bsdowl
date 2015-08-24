### TestMetapostTeX.mk -- Metapost figure using TeX labels

# Author: Michael Grünewald
# Date: Wed Dec  3 07:56:22 CET 2014

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

DOCUMENT=		texlabel.mp
MPDEVICE=		eps

test:
	test -f ${DESTDIR}${DOCDIR}/texlabel-1.eps

.PATH:			${BSDOWLSRCDIR}/example/texmf/metapost

.include "mpost.doc.mk"

### End of file `TestMetapostTeX.mk'
