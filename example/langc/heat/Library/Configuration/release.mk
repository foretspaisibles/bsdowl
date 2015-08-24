### release.mk -- Configuration for releases

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2015 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

.if !empty(THISMODULE:Mlangc.prog)
CFLAGS=			-O2 -pipe
.endif

.if !empty(THISMODULE:Mlangc.lib)
CFLAGS=			-O2 -pipe
.endif

### End of file `release.mk'
