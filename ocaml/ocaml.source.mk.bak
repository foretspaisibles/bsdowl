### ocaml.source.mk -- Scanning lists of source files

# Author: Michael Grünewald
# Date: Wed Aug  1 11:47:44 CEST 2007

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


### SYNOPSIS

# _OCAML_SRCS=SRCS.prog1 SRCS.prog2 SRCS.lib1
#
# SRCS.prog1= src11.ml src12.ml sec13.mli
# SRCS.prog2= src21.ml src22.ml
# SRCS.lib1= mod1.ml lexer.mll parser.mly
#
# .include "ocaml.source.mk"

### DESCRIPTION

# We scan the lists of sources files enumerated in _OCAML_SRCS and
# assign their content to specialised lists (such as _OCAML_ML and
# _OCAML_MLI are) accordinf to their type.
#
# Each time that we meet an implementation file, the correponding
# interface file is appended to _OCAML_MLI.
#
# This module is intended to be included by other modules rather than
# to serve as is to the end user. (See ocaml.manual.mk for a
# module producing HTML documentation.)

.if !defined(THISMODULE)
.error ocaml.source.mk cannot be included directly.
.endif

.if !target(__<ocaml.source.mk>__)
__<ocaml.source.mk>__:

# _OCAML_SOURCE = _OCAML_MLY
# _OCAML_SOURCE+= _OCAML_MLL
# _OCAML_SOURCE+= _OCAML_MLI
# _OCAML_SOURCE+= _OCAML_ML
# _OCAML_SOURCE+= _OCAML_C
# _OCAML_SOURCE+= _OCAML_H

# REMARK(michipili) About the M modificator
#
#  When we use the match `M` modificator in variable expansion, the
#  pattern is *everything* that follows it.  For instance
#
#    ${VAR:M*.${SUFFIX}}
#
#  is analysed as
#
#    ${<variable>}}
#    <variable>=VAR:M*.${SUFFIX
#
#  and expands to a `}`.  But if we write things like
#
#    .for suffix in ${SUFFIX}
#    ${VAR:M*.${suffix}}
#    .endfor
#
#  then the expansion of ${suffix} precedes the expansion of the
#  surrounding match modificator and we obtan the expected result.

.for src in ${_OCAML_SRCS}
.if defined(${src})
.if !empty(${src}:M*.mli)
.for if in ${${src}:M*.mli}
.if empty(_OCAML_MLI:M${if})
_OCAML_MLI+=${if}
.endif
.endfor
.endif
.if !empty(${src}:M*.ml)
.for unit in ${${src}:M*.ml}
.if empty(_OCAML_ML)||empty(_OCAML_ML:M${unit})
_OCAML_ML+=${unit}
.endif
.endfor
.endif
.endif
.endfor


.if defined(_OCAML_ML)&&!empty(_OCAML_ML)
.for if in ${_OCAML_ML:.ml=.mli}
.if exists(${if})&&(empty(_OCAML_MLI)||empty(_OCAML_MLI:M${if}))
_OCAML_MLI+= ${if}
.endif
.endfor
.endif

.endif # !target(__<ocaml.source.mk>__)

### End of file `ocaml.source.mk'
