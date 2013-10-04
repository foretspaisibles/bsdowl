### bps.usertarget.mk -- Cibles de l'insterface utilisateur

# Author: Michael Grünewald
# Date: Sam  7 jul 2007 09:59:15 CEST
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

# _MAKE_USERTARGET = configure depend build doc all install
# _MAKE_USERTARGET+= clean distclean realclean update
# _MAKE_ALLSUBTARGET = configure depend build doc
#
# .include "bps.usertarget.mk"


### DESCRIPTION

# Définit une recette de production pour chaque cible administrative énumérée
# par la variable _MAKE_USERTARGET. Définit une cible administrative `all' qui
# appelle le programme `make' pour produire chacune des cibles énumérées dans
# _MAKE_ALLSUBTARGET.
#
# Pour chaque cible ${target} figurant dans _MAKE_USERTARGET et pour
# laquelle il n'existe pas de recettes, on définit une recette, de la
# façon suivante:
#  -- si une des cibles pre-${target}, do-${target} ou post-${target}
#     existe, alors la recette de ${target} est vide et la production
#     de ${target} dépend des cibles pre-do-post existantes;
#  -- sinon, une recette affichant un message ``Nothing to do'' est
#     préparée.


.if !target(__<bps.usertarget.mk>__)
__<bps.usertarget.mk>__:

#
# Dépendances pre-do-post
#

# On insère les dépendances * -> pre-*,  * -> do-* et * -> post-*
# dans le graphe des recettes lorsque le membre de droite existe.

.PHONY: ${_MAKE_USERTARGET}

.for target in ${_MAKE_USERTARGET:Nall}
.if !target(${target})
.for prefix in pre do post
.if target(${prefix}-${target})
${target}: ${prefix}-${target}
.endif
.endfor
.endif
.endfor


#
# Cible all
#

.for target in ${_MAKE_ALLSUBTARGET}
.if target(${target})
do-all: divert-${target}

divert-${target}: .USE
	@echo ${MAKE} ${target}
	@cd ${.CURDIR}; ${MAKE} ${target}
.endif
.endfor

.for prefix in pre do post
.if target(${prefix}-all)
all: ${prefix}-all
.endif
.endfor


#
# Messages
#

.for target in ${_MAKE_USERTARGET}
.if !target(${target})
${target}:
	@: ${INFO} "Nothing to do for target ${target}"
.endif
.endfor

.endif # !target(__<bps.usertarget.mk>__)

### End of file `bps.usertarget.mk'
