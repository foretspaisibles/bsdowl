### ocaml.searches.mk -- Détermination du chemin de recherche

# Author: Michaël Le Barbier Grünewald
# Date: Sam  7 jul 2007 20:26:31 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
# 
# Copyright (C) Michaël Le Barbier Grünewald - 2006-2009
# 
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# Ce module calcule la variable _OCAML_SEARCHES, c'est une liste
# d'options pouvant être passée en argument des outils de compilation
# OCAML.
#
# Ce module n'est pas destiné à l'usager.

# SEARCHES+= ../library
#
# .include "ocaml.init.mk"
# .include "ocaml.searches.mk"


### DESCRIPTION

# SEARCHES
#  Liste de dossiers à consulter pour trouver les fichiers `cmi',
#  `cmo', `cmx', `cma' et `cmxa'. Les termes de la liste sont exprimés
#  relativement à .OBJDIR.


.if !target(__<ocaml.searches.mk>__)
__<ocaml.searches.mk>__:

.if defined(SEARCHES)&&!empty(SEARCHES)
_OCAML_SEARCHES=${SEARCHES:C/^/-I /}
# Les fichiers necessitant une recherche opérée par MAKE sont ceux
# dont les suffixes sont: .cmo .cma .cmx .cmxa et .a. Les fichiers
# dont le suffixe est .cmi n'apparaissent pas sur la ligne de
# commande.
#.PATH.cmi: ${SEARCHES}
.PATH.cmo: ${SEARCHES}
.PATH.cmx: ${SEARCHES}
.PATH.cmxa: ${SEARCHES}
.PATH.cma: ${SEARCHES}
.PATH.a: ${SEARCHES}
.PATH.o: ${SEARCHES}
.endif

.if defined(_OCAML_SEARCHES) && !empty(_OCAML_SEARCHES)
.for tool in MLCI MLCB MLCN MLLB MLLN
${tool}FLAGS+=${_OCAML_SEARCHES}
.endfor
.endif

.endif # !target(__<ocaml.searches.mk>__)

### End of file `ocaml.searches.mk'
