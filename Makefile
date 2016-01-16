### Makefile -- BSD Owl

# Author: Michael Grünewald
# Date: Fri Feb 10 16:50:40 GMT 2006

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

PACKAGE=		bsdowl
OFFICER=		michipili@gmail.com
VERSION=		3.0.0-current

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

CONFIGURE=		Makefile.inc.in
CONFIGURE+=		bps/bps.bpsconfig.mk.in
CONFIGURE+=		testsuite/Makefile.inc.in
PROJECTDISTEXCLUDE=	Wiki

test: .PHONY
	${.CURDIR}/Library/Ancillary/testtool -R

.MAKEFLAGS: -I${.CURDIR}/Library/Make
.for subdir in ${SUBDIR}
.MAKEFLAGS: -I${.CURDIR}/${subdir}
.endfor

.include "generic.project.mk"

### End of file `Makefile'
