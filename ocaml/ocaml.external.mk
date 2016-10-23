### ocaml.external.mk -- Use external resources

# Author: Michael Grünewald
# Date: Sun Nov  9 21:03:50 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


### SYNOPSIS

### DESCRIPTION

.if !defined(THISMODULE)
.error ocaml.external.mk cannot be included directly.
.endif

.if !target(__<ocaml.external.mk>__)
__<ocaml.external.mk>__:

.for external_arg in ${_EXTERNAL_ocaml.findlib_ARGS}
PKGS+=			${external_arg}
.endfor

.for external_arg in ${_EXTERNAL_ocaml.lib_ARGS}
.if defined(_EXTERNAL_ocaml.lib_${external_arg}_DIR)
DIRS+=			${_EXTERNAL_ocaml.lib_${external_arg}_DIR}
.endif
.if !defined(_EXTERNAL_ocaml.lib_${external_arg}_BYTE)\
	  &&!defined(_EXTERNAL_ocaml.lib_${external_arg}_NATIVE)
_EXTERNAL_LIBS+=	${external_arg}
.endif
.if defined(_EXTERNAL_ocaml.lib_${external_arg}_BYTE)
OCAMLLBADD+=		${_EXTERNAL_ocaml.lib_${external_arg}_BYTE}
OCAMLABADD+=		${_EXTERNAL_ocaml.lib_${external_arg}_BYTE}
.endif
.if defined(_EXTERNAL_ocaml.lib_${external_arg}_NATIVE)
OCAMLLNADD+=		${_EXTERNAL_ocaml.lib_${external_arg}_NATIVE}
OCAMLANADD+=		${_EXTERNAL_ocaml.lib_${external_arg}_NATIVE}
OCAMLCSADD+=		${_EXTERNAL_ocaml.lib_${external_arg}_NATIVE}
.endif
.endfor

.endif # !target(__<ocaml.external.mk>__)

### End of file `ocaml.external.mk'
