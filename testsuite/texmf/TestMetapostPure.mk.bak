### TestMetapostPure.mk -- Pure figures using Metapost

# Author: Michael Grünewald
# Date: Sun Nov 23 19:20:52 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

TEST_DESCRIPTION=	Pure METAPOST picture
TEST_SOURCEDIR=		example/texmf/metapost

.if "${WITH_TESTSUITE_METAPOST}" == "yes"
TEST_SEQUENCE=		preparatives all install
.else
TEST_SEQUENCE=		IGNORE
.endif

TEST_MATRIX=		MPDEVICE
TEST_MPDEVICE=		eps svg pdf png

DOCUMENT=		square.mp

test:
	test -f ${DESTDIR}${DOCDIR}/square-1.${MPDEVICE}

### End of file `TestMetapostPure.mk'
