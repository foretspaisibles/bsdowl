### ocaml.init.mk -- Initialisation pour les projets OCAML

# Author: Michaël Le Barbier Grünewald
# Date: Sam  7 jul 2007 20:59:45 CEST
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

# .include "ocaml.init.mk"


### DESCRIPTION

# Ce module traite un certain nombre de directives dans des
# sous-modules.
#
# Donne une définition de la variable _OCAML_OBJECT aussi utilisée
# dans ocaml.build.mk .

.if !target(__<ocaml.init.mk>__)
__<ocaml.init.mk>__:


.SUFFIXES: .cmi .cmo .cmx .o .a .cma .cmxa

_OCAML_OBJECT = _OCAML_CMI
_OCAML_OBJECT+= _OCAML_CMO
_OCAML_OBJECT+= _OCAML_CMX
_OCAML_OBJECT+= _OCAML_O
_OCAML_OBJECT+= _OCAML_A
_OCAML_OBJECT+= _OCAML_CB
_OCAML_OBJECT+= _OCAML_CN
_OCAML_OBJECT+= _OCAML_CMA
_OCAML_OBJECT+= _OCAML_PKO
_OCAML_OBJECT+= _OCAML_PKX

.include "ocaml.target.mk"
.include "ocaml.find.mk"
.include "ocaml.tools.mk"
.include "ocaml.searches.mk"

.endif # !target(__<ocaml.init.mk>__)

### End of file `ocaml.init.mk'
