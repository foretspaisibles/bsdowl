### ocaml.find.mk -- Ligne de commande avec ocamlfind

# Author: Michael Grünewald
# Date: Sam  7 jul 2007 20:14:16 CEST

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

# USE_OCAMLFIND = yes
# PACKAGES+= unix
# PACKAGES+= nums
# PREDICATES+= mt
# .include "ocaml.target.mk"
# .include "ocaml.find.mk"
# .include "ocaml.tools.mk"


### DESCRIPTION

# We provide virtual tools based on the ocamnlfind utility upon
# explicit request of the user (USE_OCAMLFIND) or when idiosyncratic
# variables are defined (PACKAGES, PREDICATES).


.if !target(__<ocaml.find.mk>__)
__<ocaml.find.mk>__:

#
# Detect idiosyncratic variables
#

.if defined(PACKAGES)&&!empty(PACKAGES)
USE_OCAMLFIND?=yes
.endif

.if defined(PREDICATES)&&!empty(PREDICATES)
USE_OCAMLFIND?=yes
.endif


#
# Conditionally define virtual tools
#

USE_OCAMLFIND?=no

.if ${USE_OCAMLFIND} == yes
MLCB?= ocamlfind ocamlc -c
MLCN?= ocamlfind ocamlopt -c
OCAMLDOC?= ocamlfind ocamldoc
OCAMLMKTOP?= ocamlfind ocamlmktop
.if defined(_OCAML_COMPILE_NATIVE_ONLY)
MLCI?= ocamlfind ocamlopt -c
.else
MLCI?= ocamlfind ocamlc -c
.endif
MLLB?= ocamlfind ocamlc -linkpkg
MLLN?= ocamlfind ocamlopt -linkpkg
.endif

.for pseudo in MLCB MLCN MLCI MLLB MLLN OCAMLDOC OCAMLMKTOP
.if defined(PACKAGES)&&!empty(PACKAGES)
${pseudo}+= -package "${PACKAGES}"
.endif
.if defined(PREDICATES)&&!empty(PREDICATES)
${pseudo}+= -predicates "${PREDICATES}"
.endif
.endfor

.endif #!target(__<ocaml.find.mk>__)

### End of file `ocaml.find.mk'
