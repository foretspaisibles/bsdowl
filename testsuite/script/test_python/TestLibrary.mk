### TestLibrary.mk -- Test installation of Python modules

# Author: Michael Grünewald
# Date: Sat Nov 22 11:11:04 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TEST_DESCRIPTION=	Python library installed with setuptools
TEST_SOURCEDIR=		example/script/python/funniest

.if "${WITH_TESTSUITE_PY_SETUPTOOLS}" == "yes"
TEST_SEQUENCE=		preparatives all install
.else
TEST_SEQUENCE=		IGNORE
.endif

### End of file `TestLibrary.mk'
