### ocaml.init.mk -- Common initialisation for OCaml projects

# Author: Michael Grünewald
# Date: Sat Jul  7 20:59:45 CEST 2007

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

# .include "ocaml.init.mk"


### DESCRIPTION

# This modules is responsible for early initialisation of some
# variables used by our OCaml framework. It defines _OCAML_OBJECT and
# reads in several modules.
#
# This module is intended to be included by other modules rather than
# to serve as is to the end user.

# Variables:
#
#
#  _OCAML_OBJECT
#   The list of object groups handled by our framework
#
#
#  LIBDIR
#   The installation target for libraries
#
#   The value defined in `bps.own.mk` is suited for C libraries but not
#   for OCaml objects that are rather installed in the same location as
#   the standard library.
#
#   It takes into account the APPLICATIONDIR variable.


### IMPLEMENTATION

.if !target(__<ocaml.init.mk>__)
__<ocaml.init.mk>__:

.if !defined(APPLICATIONDIR)||empty(APPLICATIONDIR)
LIBDIR?=${PREFIX}/lib/ocaml${APPLICATIONDIR}
.else
LIBDIR?=${PREFIX}/lib/ocaml/site-lib${APPLICATIONDIR}
.endif


.SUFFIXES: .cmi .cmo .cmx .o .a .cma .cmxa

_OCAML_OBJECT = _OCAML_CMI
_OCAML_OBJECT+= _OCAML_CMO
_OCAML_OBJECT+= _OCAML_CMX
_OCAML_OBJECT+= _OCAML_O
_OCAML_OBJECT+= _OCAML_A
_OCAML_OBJECT+= _OCAML_CB
_OCAML_OBJECT+= _OCAML_CN
_OCAML_OBJECT+= _OCAML_CMA
_OCAML_OBJECT+= _OCAML_CMXA
_OCAML_OBJECT+= _OCAML_PKO
_OCAML_OBJECT+= _OCAML_PKX

.include "ocaml.target.mk"
.include "ocaml.find.mk"
.include "ocaml.tools.mk"
.include "ocaml.dirs.mk"

.endif # !target(__<ocaml.init.mk>__)

### End of file `ocaml.init.mk'
