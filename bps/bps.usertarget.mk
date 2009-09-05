### bps.usertarget.mk -- Cibles de l'insterface utilisateur

# Author: Michaël Le Barbier Grünewald
# Date: Sam  7 jul 2007 09:59:15 CEST
# Lang: fr_FR.ISO8859-15

# $Id$

# Copyright (c) 2006, 2007, 2008, 2009 Michaël Le Barbier Grünewald
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

# _MAKE_USERTARGET = configure depend build doc all install
# _MAKE_USERTARGET+= clean distclean realclean
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
