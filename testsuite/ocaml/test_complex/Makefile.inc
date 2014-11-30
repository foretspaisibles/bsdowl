### Makefile.inc -- Configuration for golden_ratio

# Author: Michael Grünewald
# Date: Sun Nov 30 15:09:47 CET 2014

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

.if "${THISMODULE}" == "ocaml.lib"
USES+=			ocamldoc:odoc
.endif

### End of file `Makefile.inc'
