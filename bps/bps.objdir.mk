### bps.objdir.mk -- %%DESCRIPTION%%

# Author: Michaël Grünewald
# Date: Sam 15 mar 2008 20:51:30 CET
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

# .include "bps.objdir.mk"


### DESCRIPTION


### IMPLÉMENTATION

.if !target(__<bps.objdir.mk>__)
__<bps.objdir.mk>__:

#
# Contrôle de MAKEOBJDIRPREFIX et MAKEOBJDIR
#

# On vérifie que les variables MAKEOBJDIRPREFIX et MAKEOBJDIR n'ont
# pas été positionnées sur la ligne de commande ou dans le fichier de
# directives (cf. make(1), .OBJDIR).

_MAKE_OBJDIRPREFIX!= ${ENVTOOL} -i PATH=${PATH} ${MAKE} \
	${.MAKEFLAGS:MMAKEOBJDIRPREFIX=*} -f /dev/null -V MAKEOBJDIRPREFIX nothing

.if !empty(_MAKEOBJDIRPREFIX)
.error MAKEOBJDIRPREFIX can only be set in environment, not as a global\
	(in make.conf(5)) or command-line variable.
.endif

_MAKE_OBJDIR!= ${ENVTOOL} -i PATH=${PATH} ${MAKE} \
       ${.MAKEFLAGS:MMAKEOBJDIR=*} -f /dev/null -V MAKEOBJDIR nothing

.if !empty(_MAKEOBJDIR)
.error MAKEOBJDIR can only be set in environment, not as a global\
       (in bps.conf(5)) or command-line variable.
.endif



.undef _MAKE_OBJDIRPREFIX
.undef _MAKE_OBJDIR


#
# Initialisation
#

.if defined(MAKEOBJDIR)||defined(MAKEOBJDIRPREFIX)
USE_OBJDIR?= yes
.else
USE_OBJDIR?= no
.endif

#
# User targets
#

.if ${USE_OBJDIR} == yes
_MAKE_USERTARGET+= obj
_MAKE_ALLSUBTARGET+= obj

do-obj:
.if defined(MAKEOBJDIRPREFIX)
	${INSTALL_DIR} ${MAKEOBJDIRPREFIX}/${.CURDIR}
.elif defined(MAKEOBJDIR)
	${INSTALL_DIR} ${MAKEOBJDIR}
.endif

.if ${.OBJDIR} != ${.CURDIR}
distclean:
	@rm -Rf ${.OBJDIR}
.endif

.endif # USE_OBJDIR

.endif # !target(__<bps.objdir.mk>__)

### End of file `bps.objdir.mk'
