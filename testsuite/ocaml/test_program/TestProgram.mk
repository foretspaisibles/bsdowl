### TestProgram.mk -- Counting characters and lines in a file

# Author: Michael Grünewald
# Date: Thu Oct  3 22:42:23 CEST 2013

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

PROGRAM=	wordcount

test:
	test -x ${DESTDIR}${BINDIR}/wordcount
	test -f ${DESTDIR}${MANDIR}/man1/wordcount.1.gz

.include "ocaml.prog.mk"

### End of file `TestProgram.mk'
