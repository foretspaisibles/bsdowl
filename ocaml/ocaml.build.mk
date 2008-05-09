### ocaml.build.mk -- Création des lignes de commandes

# Author: Michaël Grünewald
# Date: Mar  5 avr 2005 10:31:04 GMT
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

# _OCAML_CMO=module1.cmo module2.cmo module3.cmo
# _OCAML_CMX=module1.cmx module2.cmx module3.cmx
# _OCAML_CMI=module1.cmi
# _OCAML_CMA=library.cma
# _OCAML_CMXA=library.cmxa
# _OCAML_CB=prog1.cb
# _OCAML_CN=prog1.cn
#
# OBJS.library.cma=module1.cmo module2.cmo module3.cmo
# OBJS.library.cmxa=module1.cmx module2.cmx module3.cmx
#
# .include "ocaml.init.mk"
# .include "ocaml.build.mk"


### DESCRIPTION

# Ce module fournit à ses clients des procédures pour la compilation
# des unités apparaissant dans les diverses variables '_OCAML_*'. Les
# unités concernées sont celles en '.cmx' '.cmo' '.cmi' '.cma' et
# '.cmxa'.
#
# Pour chaque objet, la ligne de production est
#
#  ${obj}:
#	${_OCAML_BUILD.${obj:T}} ${.ALLSRC}
#


### RÉALISATION

_OCAML_CMI.cmd=MLCI
_OCAML_CMI.obj=_OCAML_CMI
_OCAML_CMI.var=MLCIFLAGS MLCFLAGS MLFLAGS

_OCAML_CMO.cmd=MLCB
_OCAML_CMO.obj=_OCAML_CMO
_OCAML_CMO.var=MLCBFLAGS MLCFLAGS MLFLAGS

_OCAML_CMX.cmd=MLCN
_OCAML_CMX.obj=_OCAML_CMX
_OCAML_CMX.var=MLCNFLAGS MLCFLAGS MLFLAGS

_OCAML_CB.cmd=MLLB
_OCAML_CB.obj=_OCAML_CB
_OCAML_CB.var=MLLBFLAGS MLLFLAGS MLFLAGS MLLBADD

_OCAML_CN.cmd=MLLN
_OCAML_CN.obj=_OCAML_CN
_OCAML_CN.var=MLLNFLAGS MLLFLAGS MLFLAGS MLLNADD

_OCAML_CMA.cmd=MLAB
_OCAML_CMA.obj=_OCAML_CMA
_OCAML_CMA.var=MLABFLAGS MLAFLAGS MLFLAGS MLABADD

_OCAML_CMXA.cmd=MLAN
_OCAML_CMXA.obj=_OCAML_CMXA
_OCAML_CMXA.var=MLANFLAGS MLAFLAGS MLFLAGS MLANADD

#
# Spécialisation des variables
#

# On spécialise les variables associées aux différents objets, d'après
# les prescriptions préceentes.
#
# Par exemple, pour les objets _OCAML_CN (éxécutables en code natif),
# les variables MLLNFLAGS, MLLFLAGS, MLFLAGS et MLLNADD sont
# spécialisées pour les membres apparaissant dans la liste _OCAML_CN.

.for thg in ${_OCAML_OBJECT}
.for obj in ${${${thg}.obj}}
.for var in ${${thg}.var}
.if !defined(${var}.${obj:T})
.if defined(${var})
${var}.${obj:T}=${${var}}
.endif
.endif
.endfor
.endfor
.endfor

#
# Préparation de la ligne de commande
#

.for thg in ${_OCAML_OBJECT}
.for obj in ${${${thg}.obj}}
.if !defined(_OCAML_BUILD.${obj:T})
_OCAML_BUILD.${obj:T}=${${${thg}.cmd}}
#
# Flags
#
.for var in ${${thg}.var:M*FLAGS}
.if defined(${var}.${obj:T})&&!empty(${var}.${obj:T})
_OCAML_BUILD.${obj:T}+=${${var}.${obj:T}}
.endif
.endfor
#
# Output name
#
_OCAML_BUILD.${obj:T}+=-o ${.TARGET}
#
# Additional parameters
#
.if !empty(${thg}.var:M*ADD)
.for var in ${${thg}.var:M*ADD}
.if defined(${var}.${obj:T})&&!empty(${var}.${obj:T})
_OCAML_BUILD.${obj:T}+=${${var}.${obj:T}}
.endif
.endfor
.endif

.endif

# XXX Indiquer que le fichier CMI est produit avec le fichier CMX/CMO.

.if (empty(_OCAML_CMO)||empty(_OCAML_CMO:M${obj}))&&(empty(_OCAML_CMX)||empty(_OCAML_CMX:M${obj}))
${obj}:
.else
if:=${obj:C/.cm[xo]/.cmi/}
.if !(empty(_OCAML_CMI)||empty(_OCAML_CMI:M${if}))
${obj}: ${if}
${obj}:
.else
.if !target(${if})
${obj} ${if}:
.else
${obj}: ${if}
${obj}:
.endif
.endif
.endif
.undef if
	${_OCAML_BUILD.${obj:T}} ${.ALLSRC:N*.cmi}

.endfor
.endfor

### End of file `ocaml.build.mk'
