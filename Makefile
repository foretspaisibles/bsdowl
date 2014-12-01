### Makefile -- BSD Owl

# Author: Michael Grünewald
# Date: Fri Feb 10 2006 16:50:40 GMT

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

SUBDIR+=		bps
SUBDIR+=		ocaml
SUBDIR+=		texmf
SUBDIR+=		langc
SUBDIR+=		noweb
SUBDIR+=		config
SUBDIR+=		script
SUBDIR+=		misc
SUBDIR+=		www
SUBDIR+=		support
SUBDIR+=		testsuite

CONFIGURE=		Makefile.inc.in
CONFIGURE+=		bps/bps.bpsconfig.mk.in
PROJECTDISTEXCLUDE=	Wiki

test: .PHONY
	@(cd testsuite && ${MAKE} test)

.MAKEFLAGS: -I${.CURDIR}/Library/Make
.MAKEFLAGS: -I${.CURDIR}/bps

.include "bsdowl.mk"

### End of file `Makefile'
