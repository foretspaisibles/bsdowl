### bps.objdir.mk -- Utilisation de OBJDIR

# Author: Michael Grünewald
# Date: Sam 15 mar 2008 20:51:30 CET
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


### SYNOPSIS

# .include "bps.objdir.mk"


### DESCRIPTION

# Le programme BSD Make dispose de certaines fonctionnalités
# permettant de produire le code objet dans un répertoire différent de
# celui contenant le code source. Ce module propose une interface
# simplifiée vers ces fonctionnalités.
#
# Note: Plus que tout autre, ce module de directives peut entraîner la
#   perte de données par son utilisation maladroite.

#
# Description des variables
#

# MAKE_OBJDIR
# MAKE_OBJDIRPREFIX
# USE_OBJDIR

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

.if !empty(_MAKE_OBJDIRPREFIX)
.error MAKEOBJDIRPREFIX can only be set in environment, not as a global\
	(in make.conf(5)) or command-line variable.
.endif

_MAKE_OBJDIR!= ${ENVTOOL} -i PATH=${PATH} ${MAKE} \
       ${.MAKEFLAGS:MMAKEOBJDIR=*} -f /dev/null -V MAKEOBJDIR nothing

.if !empty(_MAKE_OBJDIR)
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
