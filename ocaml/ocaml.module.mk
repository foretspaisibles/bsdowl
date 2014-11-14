### ocaml.module.mk -- Take in account other modules of the project

# Author: Michael Grünewald
# Date: Sun Nov  9 21:03:28 CET 2014

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


### SYNOPSIS

### DESCRIPTION

# Take into account other modules of the package.

.if !defined(THISMODULE)
.error ocaml.module.mk cannot be included directly.
.endif

.if !target(__<ocaml.module.mk>__)
__<ocaml.module.mk>__:

.for module_path in ${_MODULE_langc.lib_ARGS}
DIRS+=			${SRCDIR}/${module_path}
.endfor

.for module_path in ${_MODULE_ocaml.lib_ARGS}
DIRS+=			${SRCDIR}/${module_path}
.endfor

.for module_path in ${_MODULE_ocaml.pack_ARGS}
DIRS+=			${SRCDIR}/${module_path}
.endfor

.if ${THISMODULE} == ocaml.prog
.for library in ${PRODUCT_ocaml.lib:N*.odoc}
LIBS+=			${library}
.endfor
.for library in ${PRODUCT_ocaml.pack:N*.odoc}
LIBS+=			${library}
.endfor
.endif

.if ${THISMODULE} == ocaml.manual
.for manual in ${PRODUCT_ocaml.lib:M*.odoc}
MANUAL+=		${manual}
.endfor
.endif

.endif # !target(__<ocaml.module.mk>__)

### End of file `ocaml.module.mk'
