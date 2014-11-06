### Makefile -- Test features of module ocaml.prog

# Author: Michael Grünewald
# Date: Thu Oct  3 22:42:23 CEST 2013

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

TEST=	TestProgram
TEST+=	TestProgramNative
TEST+=	TestProgramDebug
TEST+=	TestProgramMultiple

# The test TestProgramNoObjDir must be at the end of the list, because
# it builds its objects in ${.CURDIR} and these objects would be found
# by all tests following it.  Actually, this test should be built in
# its own directory.

TEST+=	TestProgramNoObjDir

.include "test.mk"

### End of file `TestProgram.mk'
