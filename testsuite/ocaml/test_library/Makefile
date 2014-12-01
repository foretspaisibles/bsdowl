### Makefile -- Test features of module ocaml.lib

# Author: Michael Grünewald
# Date: Sat Nov 29 08:08:34 CET 2014

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

TEST=			TestLibrary
TEST+=			TestLibraryDoc

.if "${WITH_TESTSUITE_FINDLIB}" == "yes"
TEST+=			TestLibraryFindlib
.endif

TEST+=			TestPack

.include "test.mk"

### End of file `Makefile'
