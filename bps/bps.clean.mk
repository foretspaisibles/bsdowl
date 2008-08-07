### bps.clean.mk -- Service pour l'effacement de fichiers

# Auteur: Michaël Grünewald
# Date: Ven 10 fév 2006 10:40:49 GMT
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

# CLEANFILES+= ${OBJ}
# CLEANDIRS+= ${OBJDIR}
# DISTCLEANFILES+= ${CONFOBJ}
# DISTCLEANDIRS+= ${CONFOBJDIR}
# REALCLEANFILES+= ${CONF}
# REALCLEANDIRS+= ${CONFDIR}
#
# .include "bps.clean.mk"


### DESCRIPTION

# Le module `bps.clean.mk' fournit un service pour effacer les
# fichiers objets et remettre le répertoire de travail dans son état
# initial.
#
# Pour cela, le module `bps.clean.mk' utilise les valeurs des
# variables CLEANFILES, CLEANDIRS, DISTCLEANFILES, DISTCLEANDIRS,
# REALCLEANFILES, REALCLEANDIRFILES, pour créer des cibles
# do-cleanfiles, do-cleandirs, do-distcleanfiles, do-distcleandirs,
# do-realcleanfiles et do-realcleandirs et les faire dépendre de
# do-clean et do-distclean respectivement.

.if !target(__<bps.clean.mk>__)
__<bps.clean.mk>__:
#
# Clean files
#
.if defined(CLEANFILES)&&!empty(CLEANFILES)
do-clean: do-clean-cleanfiles
do-clean-cleanfiles:
	${RM} -f ${CLEANFILES}
.endif
#
# Clean dirs
#
.if defined(CLEANDIRS)&&!empty(CLEANDIRS)
do-clean: do-clean-cleandirs
do-clean-cleandirs:
	${RM} -f -r ${CLEANDIRS}
.endif
#
# Distclean files
#
.if defined(DISTCLEANFILES)&&!empty(DISTCLEANFILES)
do-distclean: do-distclean-distcleanfiles
do-distclean-distcleanfiles:
	${RM} -f ${DISTCLEANFILES}
.endif
#
# Distclean dirs
#
.if defined(DISTCLEANDIRS)&&!empty(DISTCLEANDIRS)
do-distclean: do-distclean-distcleandirs
do-distclean-distcleandirs:
	${RM} -f -r ${DISTCLEANDIRS}
.endif
#
# Realclean files
#
.if defined(REALCLEANFILES)&&!empty(REALCLEANFILES)
do-realclean: do-realclean-realcleanfiles
do-realclean-realcleanfiles:
	${RM} -f ${REALCLEANFILES}
.endif
#
# Realclean dirs
#
.if defined(REALCLEANDIRS)&&!empty(REALCLEANDIRS)
do-realclean: do-realclean-realcleandirs
do-realclean-realcleandirs:
	${RM} -f -r ${REALCLEANDIRS}
.endif

.if target(clean)&&target(distclean)
distclean: clean
.endif

.if target(distclean)&&target(realclean)
realclean: distclean
.endif

.if target(clean)&&target(realclean)
realclean: clean
.endif

.if target(do-distclean)
distclean: do-distclean
.endif

.if target(do-realclean)
realclean: do-realclean
.endif

.ORDER: clean distclean realclean

.endif # !target(__<bps.clean.mk>__)

### End of file `bps.clean.mk'
