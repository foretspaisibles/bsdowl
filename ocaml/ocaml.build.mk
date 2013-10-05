### ocaml.build.mk -- Création des lignes de commandes

# Author: Michael Grünewald
# Date: Mar  5 avr 2005 10:31:04 GMT
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

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

_OCAML_PKO.cmd=MLPB
_OCAML_PKO.obj=_OCAML_PKO
_OCAML_PKO.var=MLCBFLAGS MLCFLAGS MLFLAGS

_OCAML_PKX.cmd=MLPN
_OCAML_PKX.obj=_OCAML_PKX
_OCAML_PKX.var=MLCNFLAGS MLCFLAGS MLFLAGS

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

.if !empty(_OCAML_CMXA:M${obj})
# We are producing a CMXA file
clib:=${obj:C/.cmxa/.a/}
.if !target(${clib})
# The C library file will be produced by ocamlmklib
${clib}: ${obj}
	@${DO_NADA}
.endif
.undef clib
.endif
.if (empty(_OCAML_CMO)||empty(_OCAML_CMO:M${obj}))&&(empty(_OCAML_CMX)||empty(_OCAML_CMX:M${obj}))
# We are not building a CMO nor a CMX file
${obj}:
	${_OCAML_BUILD.${obj:T}} ${.ALLSRC:N*.cmi}
.else
# We are building a CMO or a CMX file
if:=${obj:C/.cm[xo]/.cmi/}
.if !(empty(_OCAML_CMI)||empty(_OCAML_CMI:M${if}))
${obj}: ${if}
${obj}:
.else
.if !target(${if})
# The CMI file will be produced from the object
${if}: ${obj}
	${NOP}
${obj}:
.else
# The CMI file comes from a MLI that is previously built
${obj}: ${if}
${obj}:
.endif
.endif
	${_OCAML_BUILD.${obj:T}} ${.TARGET:C/.cm[xoi]/.ml/}
.endif
.undef if


.endfor
.endfor

### End of file `ocaml.build.mk'
