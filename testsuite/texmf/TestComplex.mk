### TestComplex.mk -- Complex document using LaTeX

# Author: Michael Grünewald
# Date: Sun Nov 23 22:53:22 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TEST_DESCRIPTION=	Complex LaTeX document with METAPOST figures
TEST_SOURCEDIR=		example/texmf/complex

.if "${WITH_TESTSUITE_TEXMF}" == "yes"
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
	test -f ${DESTDIR}${DOCDIR}/complex.${texdevice}
.endfor

### End of file `TestComplex.mk'
