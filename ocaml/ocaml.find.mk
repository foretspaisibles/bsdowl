### ocaml.find.mk -- Ligne de commande avec ocamlfind

# Author: Michaël Grünewald
# Date: Sam  7 jul 2007 20:14:16 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

# Copyright (c) 2006, 2007, 2008, Michaël Grünewald
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

# USE_OCAMLFIND = yes
# PACKAGES+= unix
# PACKAGES+= nums
# PREDICATES+= mt
# .include "ocaml.target.mk"
# .include "ocaml.find.mk"
# .include "ocaml.tools.mk"


### DESCRIPTION

# Ce module détermine grâce à la présence d'une liaison pour l'une des
# variables PACKAGES, PREDICATES ou USE_OCAMLFIND, si l'usager
# souhaite utiliser ocamlfind. Dans ce cas, ce module les
# pseudo-commandes pour la compilation et l'édition de lien avec
# OCAMLFIND.


.if !target(__<ocaml.find.mk>__)
__<ocaml.find.mk>__:

.if defined(PACKAGES)&&!empty(PACKAGES)
USE_OCAMLFIND=yes
.endif

.if defined(PREDICATES)&&!empty(PREDICATES)
USE_OCAMLFIND=yes
.endif

USE_OCAMLFIND?=no

.if ${USE_OCAMLFIND} == yes
MLCB?= ocamlfind ocamlc -c
MLCN?= ocamlfind ocamlopt -c
OCAMLDOC?= ocamlfind ocamldoc
.if !empty(TARGET:Mbyte_code)
MLCI?= ocamlfind ocamlc -c
.else
MLCI?= ocamlfind ocamlopt
.endif
MLLB?= ocamlfind ocamlc -linkpkg
MLLN?= ocamlfind ocamlopt -linkpkg
.endif

.for pseudo in MLCB MLCN MLCI MLLB MLLN OCAMLDOC
.if defined(PACKAGES)&&!empty(PACKAGES)
${pseudo}+= -package "${PACKAGES}"
.endif
.if defined(PREDICATES)&&!empty(PREDICATES)
${pseudo}+= -predicates "${PREDICATES}"
.endif
.endfor

.endif #!target(__<ocaml.find.mk>__)

### End of file `ocaml.find.mk'
