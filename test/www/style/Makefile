# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION
WWW+= modern.css
WWW+= modern_sz.css

WWW+= classic.css
WWW+= classic_sz.css

WWW+= trendy.css

WWW+= content.css
WWW+= more.css
WWW+= title.css
WWW+= layout.css
WWW+= scroll_layout.css

WWWDIR = ${WWWBASE}/style

#
# update:
#  Brings the last style files into this directory
#

WPAGESDIR?= ${HOME}/Workshop/wpages

.if exists(${WPAGESDIR}/style)
update:
	cd ${WPAGESDIR} && ${MAKE} PREFIX='${HOME}' WWWDIR='${.CURDIR}' all install
.else
update:
	${FAIL} WPAGESDIR not found
.endif

.include "www.files.mk"
