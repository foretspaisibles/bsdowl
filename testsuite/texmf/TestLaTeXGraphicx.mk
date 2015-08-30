### TestLaTeXGraphicx.mk -- LaTeX document with METAPOST figures

# Author: Michael Grünewald
# Date: Sun Nov 23 17:58:30 CET 2014

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

TEST_DESCRIPTION=	LaTeX document with METAPOST figures
TEST_SOURCEDIR=		example/texmf/graphicx

.if "${WITH_TESTSUITE_TEXMF}" == "yes" && "${WITH_TESTSUITE_METAPOST}" == "yes"
TEST_SEQUENCE=		preparatives all install
.else
TEST_SEQUENCE=		IGNORE
.endif

TEST_MATRIX=		TEXDEVICE
TEST_TEXDEVICE=		dvi pdf ps

test:
.for mpdevice in ${TEXDEVICE:Mdvi:S/dvi/eps/}
	test -f ${DESTDIR}${DOCDIR}/square-1.${mpdevice}
.endfor
.for texdevice in ${TEXDEVICE}
	test -f ${DESTDIR}${DOCDIR}/illustrated.${texdevice}
.endfor

### End of file `TestLaTeXGraphicx.mk'
