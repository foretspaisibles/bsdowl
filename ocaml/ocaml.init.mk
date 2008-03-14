### ocaml.init.mk -- Initialisation pour les projets OCAML

# Author: Michaël Grünewald
# Date: Sam  7 jul 2007 20:59:45 CEST
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

# .include "ocaml.init.mk"


### DESCRIPTION

# Ce module traite un certain nombre de directives dans des
# sous-modules.
#
# Donne une définition de la variable _OCAML_OBJECT aussi utilisée
# dans ocaml.build.mk .

.if !target(__<ocaml.init.mk>__)
__<ocaml.init.mk>__:

_OCAML_OBJECT = _OCAML_CMI
_OCAML_OBJECT+= _OCAML_CMO
_OCAML_OBJECT+= _OCAML_CMX
_OCAML_OBJECT+= _OCAML_O
_OCAML_OBJECT+= _OCAML_A
_OCAML_OBJECT+= _OCAML_CB
_OCAML_OBJECT+= _OCAML_CN
_OCAML_OBJECT+= _OCAML_CMA
_OCAML_OBJECT+= _OCAML_CMXA

.include "ocaml.target.mk"
.include "ocaml.find.mk"
.include "ocaml.tools.mk"
.include "ocaml.searches.mk"

.endif # !target(__<ocaml.init.mk>__)

### End of file `ocaml.init.mk'
