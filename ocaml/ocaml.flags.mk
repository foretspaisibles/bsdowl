### ocaml.flags.mk -- Modificateurs de la ligne de commande

# Author: Michaël Grünewald
# Date: Mer  1 aoû 2007 12:12:32 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

# Copyright (c) 2008, Michaël Grünewald
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#    1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#    2. Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#
#    3. The name of the author may not be used to endorse or promote
#    products derived from this software without specific prior written
#    permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.


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
