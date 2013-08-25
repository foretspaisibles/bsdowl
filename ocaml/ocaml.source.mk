### ocaml.source.mk -- SOURCE

# Author: Michael Grünewald
# Date: Mer  1 aoû 2007 11:47:44 CEST

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

# _OCAML_SRCS=SRCS.prog1 SRCS.prog2 SRCS.lib1
#
# SRCS.prog1= src11.ml src12.ml sec13.mli
# SRCS.prog2= src21.ml src22.ml
# SRCS.lib1= mod1.ml lexer.mll parser.mly
# .include "ocaml.source.mk"

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
