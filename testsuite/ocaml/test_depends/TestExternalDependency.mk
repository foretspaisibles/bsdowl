### TestExternalDependency.mk -- Validate external dependencies

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

TEST_DESCRIPTION=	External dependencies in an OCaml project
TEST_SOURCEDIR=		example/ocaml/heat

.if "${WITH_TESTSUITE_FINDLIB}" == "yes"
TEST_SEQUENCE=		preparatives depend
.else
TEST_SEQUENCE=		IGNORE
.endif

TEST_MATRIX=		COMPILE
TEST_COMPILE=		both native_code byte_code

USES+=			compile:${COMPILE}

test:
	grep -q 'num[.]cmi' ${WRKDIR}/fibonacci/.depend

### End of file `TestExternalDependency.mk'
