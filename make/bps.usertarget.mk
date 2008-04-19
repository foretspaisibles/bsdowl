### bps.usertarget.mk -- Cibles de l'insterface utilisateur

# Author: Michaël Grünewald
# Date: Sam  7 jul 2007 09:59:15 CEST
# Lang: fr_FR.ISO8859-15

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

# _MAKE_USERTARGET = configure depend build doc all install clean distclean
# _MAKE_ALLSUBTARGET = configure depend build doc
# .include "bps.usertarget.mk"


### DESCRIPTION

# Crée les cibles pre/do/post pour les cibles de l'interface
# utilisateur, dont la liste est la valeur de la variable
# _MAKE_USERTARGET.
#
# La cible `all' appelle une liste de sous travaux, dont la liste est 


.if !target(__<bps.usertarget.mk>__)
__<bps.usertarget.mk>__:

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

.if !target(clean) && defined(CLEANFILES) && !empty(CLEANFILES)
clean:
	${RM} -f ${CLEANFILES}
.endif

.for target in ${_MAKE_USERTARGET}
.if !target(${target})
${target}:
	@: ${INFO} "Nothing to do for target ${target}"
.endif
.endfor

.if target(clean)&&target(distclean)
distclean: clean
.endif

.endif # !target(__<bps.usertarget.mk>__)

### End of file `bps.usertarget.mk'
