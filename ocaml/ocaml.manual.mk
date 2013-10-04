### ocaml.manual.mk -- Preparation of the HTML reference

# Author: Michael Grünewald
# Date: Mon Mar 10 11:59:53 CET 2008
# Cookie: DOCUMENTATION

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2006-2009, 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# MANUAL = backend.odoc
# MANUAL+= filter.odoc
#
# DIRS = backend_src
# DIRS+= filter_src
#
# .include "ocaml.manual.mk"


### DESCRIPTION

# This modules supports the prepration of a HTML reference out of
# ocamldoc(1) dump files.  These files should prepared separately.

# Variables:
#
#
#  MANUAL
#   List the ocamldoc files that should be processed
#
#
#  DIRS
#   List of paths that shall be searched for ocamldoc dump files


### IMPLEMENTATION

.include "bps.init.mk"

.if defined(MANUAL)&&!empty(MANUAL)
ODOC_FORMAT = html
.for module in ${MANUAL}
ODOC_LOAD+= ${module}
.endfor

USE_ODOC = yes

.include "ocaml.odoc.mk"
.endif

.include "bps.own.mk"
.include "bps.usertarget.mk"

### End of file `ocaml.manual.mk'
