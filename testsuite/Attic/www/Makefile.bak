SUBDIR = index
SUBDIR+= tex
SUBDIR+= ocaml
SUBDIR+= writing
SUBDIR+= generation
SUBDIR+= guidelines
SUBDIR+= style

WWWBASE?= ${.CURDIR}/wwwobj
CLEANDIRS+= ${WWWBASE}

WWWMAIN = main.sgml

.MAKEFLAGS: WWWMAIN="${WWWMAIN}"

do-publish:
	${MAKE} "PREFIX=${HOME}" "WWWBASE=${WWWBASE}" all install

.include "bps.project.mk"
.include "www.sgml.mk"
