### bps.clean.mk -- Service pour l'effacement de fichiers

# Auteur: Michaël Grünewald
# Date: Ven 10 fév 2006 10:40:49 GMT
# Lang: fr_FR.ISO8859-15

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
# 
# Copyright (C) Michaël Le Barbier Grünewald - 2006-2009
# 
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


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


#
# Cookies
#

# A ``cookie'' is a peristant bit of information used my the
# ``Makefile'' infrastructure to keep track of some event.
# There is two kind of cookies: ordinary cookies and hard cookies.  An
# ordinary cookie is removed by a simple `clean' while a hard
# cookie remains until a `distclean' or a `realclean' happens.

.if defined(COOKIEFILES)&&!empty(COOKIEFILES)
do-clean-cookies:
	@${RM} -f ${COOKIEFILES}

do-clean: do-clean-cookies
.endif

.if defined(HARDCOOKIEFILES)&&!empty(HARDCOOKIEFILES)
do-clean-hardcookies:
	@${RM} -f ${HARDCOOKIEFILES}

do-distclean: do-clean-hardcookies
.endif


.if target(do-clean)
clean: do-clean
distclean: do-clean
realclean: do-clean
.endif

.if target(do-distclean)
distclean: do-distclean
realclean: do-distclean
.endif

.if target(do-realclean)
realclean: do-realclean
.endif

.ORDER: do-realclean do-distclean do-clean

.endif # !target(__<bps.clean.mk>__)

### End of file `bps.clean.mk'
