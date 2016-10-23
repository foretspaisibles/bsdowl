### Makefile -- A simple static website

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

PACKAGE=	static
VERSION=	0.0.1-current
OFFICER?=	michipili@gmail.com

MODULE=		scroll:index
MODULE+=	scroll:tex
MODULE+=	scroll:ocaml
MODULE+=	scroll:writing
MODULE+=	scroll:generation
MODULE+=	scroll:guidelines
MODULE+=	scroll:style

#
# Prepare a local copy to browse
#

USE_SWITCH_CREDENTIALS=	no
WWWROOTDIR?=		${.CURDIR}/_build
CLEANDIRS+=		${WWWROOTDIR}

.export WWWROOTDIR
.export USE_SWITCH_CREDENTIALS

.include "generic.project.mk"

### End of file `Makefile'
