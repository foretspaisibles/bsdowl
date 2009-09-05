### ocaml.source.mk -- SOURCE

# Author: Michaël Le Barbier Grünewald
# Date: Mer  1 aoû 2007 11:47:44 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

# Copyright (c) 2006, 2007, 2008, 2009 Michaël Le Barbier Grünewald
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

# _OCAML_SRCS=SRCS.prog1 SRCS.prog2 SRCS.lib1
#
# SRCS.prog1= src11.ml src12.ml sec13.mli
# SRCS.prog2= src21.ml src22.ml
# SRCS.lib1= mod1.ml lexer.mll parser.mly
# .include

### DESCRIPTION

# Ajuste les variables _OCAML_ML, _OCAML_MLI à partir des contenus des
# variables SRCS.* dont la liste figure dans _OCAML_SRCS. Lorqu'un
# fichier .ml est accompagné d'un fichier .mli, celui-ci est
# automatiquement ajouté à _OCAML_MLI.

.if !target(__<ocaml.source.mk>__)
__<ocaml.source.mk>__:

# _OCAML_SOURCE = _OCAML_MLY
# _OCAML_SOURCE+= _OCAML_MLL
# _OCAML_SOURCE+= _OCAML_MLI
# _OCAML_SOURCE+= _OCAML_ML
# _OCAML_SOURCE+= _OCAML_C
# _OCAML_SOURCE+= _OCAML_H

# Si on utilise le modificateur M `match', le motif est tout ce qui le
# suit, de sorte que le texte de remplacement de '${VAR:M*.${SUFFIX}}'
# est toujours '}', l'analyse lexicale étant
#
#   ${<variable>}}
#   <variable>=VAR:M*.${SUFFIX
#
# On ne peut donc pas utiliser cette construction.

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

# On ajoute les fichiers de description d'interface associés aux
# fichiers de réalisation. Les doublons pouvant alors se créer (si
# l'utilisateur a lui-même ajouté le fichier de description
# d'interface) sont traités plus bas.

.if defined(_OCAML_ML)&&!empty(_OCAML_ML)
.for if in ${_OCAML_ML:.ml=.mli}
.if exists(${if})&&(empty(_OCAML_MLI)||empty(_OCAML_MLI:M${if}))
_OCAML_MLI+= ${if}
.endif
.endfor
.endif

.endif # !target(__<ocaml.source.mk>__)

### End of file `ocaml.source.mk'
