### Makefile -- BSD Owl

# Author: Michael Grünewald
# Date: Fri Feb 10 16:50:40 GMT 2006

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

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
	${.CURDIR}/Library/Ancillary/testtool -D -I -a

.MAKEFLAGS: -I${.CURDIR}/Library/Make
.for subdir in ${SUBDIR}
.MAKEFLAGS: -I${.CURDIR}/${subdir}
.endfor

.include "generic.project.mk"

### End of file `Makefile'
