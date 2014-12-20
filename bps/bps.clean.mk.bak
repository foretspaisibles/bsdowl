### bps.clean.mk -- Clean files

# Auteur: Michael Grünewald
# Date: Fri Feb 10 10:40:49 GMT 2006

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# CLEANFILES+=		${OBJ}
# CLEANDIRS+=		${OBJDIR}
# DISTCLEANFILES+=	${CONFOBJ}
# DISTCLEANDIRS+=	${CONFOBJDIR}
# REALCLEANFILES+=	${CONF}
# REALCLEANDIRS+=	${CONFDIR}
#
# .include "bps.clean.mk"


# Variables:
#
#  CLEANFILES [not set]
#    The list of files that should be removed by a clean.
#
#
#  CLEANDIRS [not set]
#    The list of directories that should be removed by a clean.
#
#
#  DISTCLEANFILES [not set]
#    The list of files that should be removed by a distclean.
#
#
#  DISTCLEANDIRS [not set]
#    The list of directories that should be removed by a distclean.
#
#
#  REALCLEANFILES [not set]
#    The list of files that should be removed by a realclean.
#
#
#  REALCLEANDIRS [not set]
#    The list of directories that should be removed by a realclean.
#
#
#  COOKIEPREFIX [.cookie.]
#    A path element used to build cookie names.
#
#
#  COOKIEFILES [not set]
#    The list of cookie files that should be removed by a clean.
#
#
#  HARDCOOKIEFILES [not set]
#    The list of cookie files that should be removed by a distclean.


# Targets:
#
#  clean, do-clean, do-clean-cleanfiles, do-clean-cleandirs
#    Targets related to a clean job.
#
#    Targets pre-clean and post-clean are created by the
#    bps.usertarget.mk file and might be used to hook the clean target.
#    If new targets are to be added to the clean target, the
#    recommanded way is to define a new target using the naming scheme
#    do-clean-cleanthings and to add the corresponding dependency to
#    do-clean.
#
#
#  distclean, do-distclean, do-distclean-cleanfiles, do-distclean-cleandirs
#    Targets related to a distclean job.
#
#    Similar comments as for clean apply.
#
#
#  realclean, do-realclean, do-realclean-cleanfiles, do-realclean-cleandirs
#    Targets related to a realclean job.
#
#    Similar comments as for clean apply.


.if !target(__<bps.clean.mk>__)
__<bps.clean.mk>__:

#
# Clean targets
#

.if defined(CLEANFILES)&&!empty(CLEANFILES)
do-clean: do-clean-cleanfiles
do-clean-cleanfiles: .PHONY
	${RM} -f ${CLEANFILES}
.endif

.if defined(CLEANDIRS)&&!empty(CLEANDIRS)
do-clean: do-clean-cleandirs
do-clean-cleandirs: .PHONY
	${RM} -f -r ${CLEANDIRS}
.endif

.if defined(DISTCLEANFILES)&&!empty(DISTCLEANFILES)
do-distclean: do-distclean-cleanfiles
do-distclean-cleanfiles: .PHONY
	${RM} -f ${DISTCLEANFILES}
.endif

.if defined(DISTCLEANDIRS)&&!empty(DISTCLEANDIRS)
do-distclean: do-distclean-cleandirs
do-distclean-cleandirs: .PHONY
	${RM} -f -r ${DISTCLEANDIRS}
.endif

.if defined(REALCLEANFILES)&&!empty(REALCLEANFILES)
do-realclean: do-realclean-cleanfiles
do-realclean-cleanfiles: .PHONY
	${RM} -f ${REALCLEANFILES}
.endif

.if defined(REALCLEANDIRS)&&!empty(REALCLEANDIRS)
do-realclean: do-realclean-cleandirs
do-realclean-cleandirs: .PHONY
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
do-clean: do-clean-cookies
do-clean-cookies: .PHONY
	@${RM} -f ${COOKIEFILES}
.endif

.if defined(HARDCOOKIEFILES)&&!empty(HARDCOOKIEFILES)
do-distclean: do-clean-hardcookies
do-clean-hardcookies: .PHONY
	@${RM} -f ${HARDCOOKIEFILES}
.endif


#
# Define targets
#

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

.if!target(display-clean)
display-clean:
	${INFO} 'Display clean information'
.for displayvar in CLEANFILES CLEANDIRS DISTCLEANFILES DISTCLEANDIRS\
	REALCLEANFILES REALCLEANDIRS\
	COOKIEPREFIX COOKIEFILES HARDCOOKIEFILES
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.endif


### End of file `bps.clean.mk'
