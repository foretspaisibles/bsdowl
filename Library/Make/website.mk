.include "bps.project.mk"

WWWMODE = 444
TEXDOCMODE = 444

WWWBASE?= ${PROJECTBASE}/wwwobj
CLEANDIRS+= ${WWWBASE}

WWWMAIN = main.sgml

.MAKEFLAGS: WWWMAIN="${WWWMAIN}"
.MAKEFLAGS: WWWMODE="${WWWMODE}"
.MAKEFLAGS: TEXDOCMODE="${TEXDOCMODE}"

do-publish:
	${MAKE} PREFIX=${HOME} WWWBASE=${PROJECTBASE}/../bps-website all install

.include "www.sgml.mk"
