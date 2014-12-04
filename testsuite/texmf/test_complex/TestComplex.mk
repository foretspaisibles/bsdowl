### TestComplex.mk -- Complex document using LaTeX

# Author: Michael Grünewald
# Date: Sun Nov 23 22:53:22 CET 2014

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

PAKCAGE=		complex
VERSION=		1.0
OFFICER=		michipili@gmail.com

SUBDIR=			chapter1
SUBDIR+=		chapter2
SUBDIR+=		main

# In this test we use several distinct TeX backends and therefore need
# to export the TEXDEVICE variable.  In a practical (non-test) case,
# the variable TEXDEVICE is likely to be set from the environement or
# from the project configuration file.

TEXDEVICE=		dvi pdf ps
.export TEXDEVICE

test:
	test -f ${DESTDIR}${DOCDIR}/complex.dvi
	test -f ${DESTDIR}${DOCDIR}/square-1.eps
	test -f ${DESTDIR}${DOCDIR}/complex.ps
	test -f ${DESTDIR}${DOCDIR}/complex.pdf

.include "generic.project.mk"

### End of file `TestComplex.mk'
