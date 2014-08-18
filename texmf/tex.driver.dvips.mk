### tex.driver.dvips.mk -- Organise la production des fichiers PostScript

# Author: Michael Grünewald
# Date: Dim  9 sep 2007 14:49:18 CEST
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

# BSD Owl Scripts (https://bitbucket.org/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2014 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

.if !target(__<tex.driver.dvips.mk>__)
__<tex.driver.dvips.mk>__:

DVIPS?= dvips

#
# Spécialisation des variables
#

# Par ordre de spécialisation croissante:
#  DVIPSFLAGS,
#  DVIPSFLAGS.document,
#  DVIPSFLAGS.document.ps,
#  DVIPSFLAGS.document.printer.ps.

.for var in DVIPSFLAGS DVIPS
.for doc in ${_TEX_DOC}
.if defined(${var})&&!empty(${var})&&!defined(${var}.${doc:T})
${var}.${doc:T} = ${${var}}
.endif
.if defined(${var}.${doc:T})&&!empty(${var}.${doc:T})&&!defined(${var}.${doc:T}.ps)
${var}.${doc:T}.ps = ${${var}.${doc:T}}
.endif
.for printer in ${PRINTERS}
.if defined(${var}.${doc:T}.ps)&&!empty(${var}.${doc:T}.ps)&&!defined(${var}.${doc:T}.${printer}.ps)
${var}.${doc:T}.${printer}.ps = ${${var}.${doc:T}.ps}
.endif
.endfor
.endfor
.endfor

#
# Création des lignes de commande
#

.for ps in ${_TEX_PS}
_DVIPS_BUILD.${ps:T} = ${DVIPS}
.for printer in ${PRINTERS}
# Le prédicat == insiste pour avoir une variable à gauche. La
# bidouille __loop__ le satisfait.
__loop__=${printer}
.if ${__loop__} == ${ps:C/.ps$//:C/^.*\.//}
_DVIPS_BUILD.${ps:T}+= -P ${printer}
.endif
.undef __loop__
.endfor
.if defined(DVIPSFLAGS.${ps:T})&&!empty((DVIPSFLAGS.${ps:T})
_DVIPS_BUILD.${ps:T}+= ${DVIPSFLAGS.${ps:T}}
.endif
_DVIPS_BUILD.${ps:T}+= -o ${ps} ${ps}.dvi
.endfor

#
# Recettes
#

# La production du fichier dvi est déléguée au module `tex.driver.dvi.mk', qui
# s'occupe de gérer correctement les variables MULTIPASS et DRAFT.

.for ps in ${_TEX_PS}
${ps}: ${ps}.dvi
	${_DVIPS_BUILD.${ps:T}}
.endfor

.endif #!target(__<tex.driver.dvips.mk>__)

### End of file `tex.driver.dvips.mk'
