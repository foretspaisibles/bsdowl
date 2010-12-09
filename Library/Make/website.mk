.include "bps.project.mk"

WWWMODE = 644
TEXDOCMODE = 644

WWWBASE = ${PROJECTBASE}/wwwobj
CLEANDIRS+= ${WWWBASE}

WWWMAIN = main.sgml
.MAKEFLAGS: WWWMAIN="${WWWMAIN}"

.include "www.sgml.mk"

publish: install

do-publish:
	${NADA}
