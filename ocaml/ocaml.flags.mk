### ocaml.flags.mk -- Modificateurs de la ligne de commande

# Author: Michael Grünewald
# Date: Mer  1 aoû 2007 12:12:32 CEST

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

# MLFLAGS.module.cm= -a
# MLFLAGS.module.cmx= -a
# MLFLAGS.module.cmo= -a

### DESCRIPTION

# Chaque pseudo outil a une variable FLAGS qui lui correspond, par
# exemple MLCB est accompagné d'une variables MLCBFLAGS et ainsi de
# suite. Certaines variables FLAGS comptent pour plusieurs outils,
# comme MLCFLAGS, MLLFLAGS ou MLFLAGS.

.if !target(__<ocaml.flags.mk>__)
__<ocaml.flags.mk>__:

_OCAML_FLAGS?=
.for radical in ML MLC MLL MLA ${_OCAML_TOOLS}
_OCAML_FLAGS+=${radical}FLAGS ${radical}ADD
.endfor

.for obj in ${_OCAML_OBJ}
.for flg in ${_OCAML_FLAG}
.if !defined(${flg}.${obj:T})&&defined(${flg})&&!empty(${flg})
${flg}.${obj:T}=${${flg}}
.endif
.endfor
.endfor

.endif#!target(__<ocaml.flags.mk>__)

### End of file `ocaml.flags.mk'
