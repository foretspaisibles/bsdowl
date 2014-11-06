### bps.files.mk -- Installation routines for file groups

# Auteur: Michael Grünewald
# Date: Ven Feb 10 2006 10:40:49 GMT

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
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

# FILESGROUPS+=		PLOPFIZZ
# PLOPFIZZDIR=		${datadir}${PACKAGEDIR}
# PLOPFIZZMODE=		${SHAREMODE}
# PLOPFIZZOWN=		${SHAREOWN}
# PLOPFIZZGRP=		${SHAREGRP}
# PLOPFIZZ=		data.pf other.pf
# PLOPFIZZMODE.data.pf=	400


### DESCRIPTION

# This file defines for its clients some routines for installing
# products on the file system, allowing to setup their emplacement,
# owner, groups and access rights.
#
# There is six canonical files groups, FILES, BIN, LIB, SHARE, DOC and
# MAN but more groups can easily be added. The installation parameters
# for these five file groups are defined by bps.own.mk, this
# definition distinguish the case when make runs with administrative
# rights or as a regular user.
#
# The installation procedures defined here are take the DESTDIR
# variable in account.


### VARIABLES

# FILESGROUPS [FILES BIN LIB DOC SHARE MAN]
#  The list of files groups.
#
# ${group}DIR
#  The directory, relative to ${DESTDIR}, for items of ${group}.
#
# ${group}MODE
#  The access mode for items of ${group}.
#
# ${group}OWN
#  The owner for items of ${group}.
#
# ${group}GRP
#  The group for items of ${group}.

# ${group}DIR.${file:T} [${${group}DIR}]
#  The installation directory for ${file}, relative to ${DESTDIR}.
#
# ${group}NAME.${file:T} [not set]
#  The name to use when installing ${file}.
#
# ${group}OWN.${file:T} [${${group}OWN}]
#  The owner to use when installing ${file}.
#
# ${group}GRP.${file:T} [${${group}GRP}]
#  The group to use when installing ${file}.
#
# ${group}MODE.${file:T} [${${group}MODE}]
#  The access mode to use when installing ${file}.
#
# COPYTREE_${group} [oneliner-script]
#  A command used to copy file trees.
#
#   A typical use is
#     cd ${SRCDIR}/doc && ${COPYTREE_SHARE} . ${DOCDIR} "! -name *\.orig"
#
#   The first argument is a path, usually '.' where to call find on,
#   the second argument is the destination directory and the last
#   argument is optional and is a find(1) predicate.

### TARGETS

# installdirs
#  A target creating target directories required by all groups.
#
# installfiles, installfiles-${group}
#  A target requiring installation of files in ${group} or in all groups.


### IMPLEMENTATION

.if !target(__<bps.files.mk>__)
__<bps.files.mk>__:

.if !target(__<bps.init.mk>__)
.error bps.files.mk cannot be included directly.
.endif

FILESGROUPS+=		FILES BIN DOC SHARE LIB MAN

.if !target(buildfiles)
.for group in ${FILESGROUPS}
buildfiles: buildfiles-${group:tl}
.PHONY: buildfiles-${group:tl}
buildfiles-${group:tl}: ${${group}}
.endfor
.endif

do-build: buildfiles
do-install: installdirs
do-install: installfiles

.if !target(installfiles)
installfiles:
.PHONY: installfiles
.for group in ${FILESGROUPS}
.if defined(${group}) && !empty(${group})
installfiles: installfiles-${group:tl}
.PHONY: installfiles-${group:tl}
installfiles-${group:tl}:
.for file in ${${group}}
installfiles-${group:tl}: installfiles-${group:tl}-${file:T}
.if !target(installfiles-${group:tl}-${file:T})
installfiles-${group:tl}-${file:T}: ${file}
	${INSTALL_${group}.${file:T}}
.endif
.PHONY: installfiles-${group:tl}-${file:T}
.endfor #file in ${${group}}
.endif #defined(${group})&&!empty(${group})
.endfor #group in ${FILESGROUPS}
.endif #!target(installfiles)

.if !target(installdirs)
installdirs:
.for group in ${FILESGROUPS}
.if defined(${group}) && !empty(${group})
	${INSTALL_DIR} ${DESTDIR}${${group}DIR}
.for item in ${${group}}
.if defined(${group}DIR.${item:T})&&!empty(${group}DIR.${item:T})
	${INSTALL_DIR} ${DESTDIR}${${group}DIR.${item:T}}
.endif
.endfor
.endif #defined(${group})&&!empty(${group})
.endfor #group in ${FILESGROUPS}
.endif #!target(installdirs)

installfiles: buildfiles


#
# Compute installation parameters
#

.for group in ${FILESGROUPS}

${group}OWN?=		${SHAREOWN}
${group}GRP?=		${SHAREGRP}
${group}MODE?=		${SHAREMODE}
${group}DIR?=		${SHAREDIR}

# Macro to install a file with the correct permissions
INSTALL_${group}?=	${INSTALL} -o ${${group}OWN}\
			-g ${${group}GRP} -m ${${group}MODE}

# Macro for copying entire directory tree with correct permissions
.if ${UID} == 0
COPYTREE_${group}=\
	${SH} -c '(${FIND} -d $$1 $$3 | ${CPIO} -dumpl $$2 >/dev/null 2>&1) &&\
		${CHOWN} -Rh ${${group}OWN}:${${group}GRP} $$2 &&\
		${FIND} -d $$1 $$3 -type d -exec ${CHMOD} 755 $$2/{} \; &&\
		${FIND} -d $$1 $$3 -type f -exec ${CHMOD} ${${group}MODE} $$2/{} \;'\
		-- COPYTREE_${group}
.else
COPYTREE_${group}=\
	${SH} -c '(${FIND} -d $$0 $$2 | ${CPIO} -dumpl $$1 >/dev/null 2>&1) &&\
		${FIND} -d $$0 $$2 -type d -exec ${CHMOD} 755 $$1/{} \; &&\
		${FIND} -d $$0 $$2 -type f -exec ${CHMOD} ${${group}MODE} $$1/{} \;'\
		-- COPYTREE_${group}
.endif

.if defined(${group}) && !empty(${group})
.for file in ${${group}}
.for record in DIR OWN GRP MODE
${group}${record}.${file:T}?=${${group}${record}}
.endfor

.if defined(${group}NAME)
${group}NAME.${file:T}?=${${group}NAME}
.endif

.if !defined(INSTALL_${group}.${file:T})
INSTALL_${group}.${file:T}=${INSTALL}\
	-o ${${group}OWN.${file:T}}\
	-g ${${group}GRP.${file:T}}\
	-m ${${group}MODE.${file:T}}\
	${.ALLSRC}
.if defined(${group}NAME.${file:T})
INSTALL_${group}.${file:T}+=\
	${DESTDIR}${${group}DIR.${file:T}}/${${group}NAME.${file:T}}
.else
INSTALL_${group}.${file:T}+=\
	${DESTDIR}${${group}DIR.${file:T}}
.endif
.endif

.endfor #file in ${${group}}
.endif #defined(${group})&&!empty(${group})
.endfor #group in ${FILESGROUPS}

.endif #!target(__<bps.files.mk>__)

#
# Display debugging information
#

.if !target(display-files)
display-files:
	${INFO} 'Display file groups information'
	${MESG} "DESTDIR=${DESTDIR}"
	${MESG} "FILESGROUPS=${FILESGROUPS}"
.for group in ${FILESGROUPS}
.for displayvar in ${group} ${group}DIR ${group}OWN ${group}GRP ${group}MODE\
	INSTALL_${group} COPYTREE_${group}
	${MESG} "${displayvar}=${${displayvar}}"
.endfor
.if defined(${group})&&!empty(${group})
.for file in ${group}
.for displayvar in ${group}DIR.${file:T} ${group}OWN.${file:T}\
	${group}GRP.${file:T} ${group}MODE.${file:T} ${group}NAME.${file:T}
.if defined(${displayvar})
	${MESG} "${displayvar}=${${displayvar}}"
.endif
.endfor
.endfor
.endif
.endfor
.endif

### End of file `bps.files.mk'
