### TestNoweb.mk -- Test noweb support with LaTeX

# Author: Michael Grünewald
# Date: Fri Nov 28 10:05:39 CET 2014

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

# IMPORTANT. This example is useful because it shows how to develop
# LaTeX packages with noweband bsdowl.  The LaTeX macros it produces
# are, however, not maintained. any more.

PACKAGE=		samhain
VERSION=		1.0
OFFICER=		michipili@gmail.com

SUBDIR=			class
SUBDIR+=		example
SUBDIR+=		manual

TEXINPUTS=		${BSDOWLSRCDIR}/noweb

.export TEXINPUTS

test-class:
	test -f ${DESTDIR}${FILESDIR}/shltx.sty
	test -f ${DESTDIR}${FILESDIR}/shthm.sty
	test -f ${DESTDIR}${FILESDIR}/sharticle.cls
	test -f ${DESTDIR}${FILESDIR}/shplexos.cls
	test -f ${DESTDIR}${FILESDIR}/shbook.cls
	test -f ${DESTDIR}${FILESDIR}/shpaper.cls
	test -f ${DESTDIR}${FILESDIR}/shmetal.sty

test-example:
	test -f ${DESTDIR}${DOCDIR}/sampleart.pdf
	test -f ${DESTDIR}${DOCDIR}/sampleart.dvi
	test -f ${DESTDIR}${DOCDIR}/sampleart.ps

test-manual:
	test -f ${DESTDIR}${DOCDIR}/shusermanual.html
	test -f ${DESTDIR}${DOCDIR}/shusermanual.pdf
	test -f ${DESTDIR}${DOCDIR}/shusermanual.dvi
	test -f ${DESTDIR}${DOCDIR}/shusermanual.ps

test: test-class test-example test-manual

.include "generic.project.mk"

### End of file `TestNoweb.mk'
