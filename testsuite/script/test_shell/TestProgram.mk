### TestProgram.mk -- Prepare and install a shell program

# Author: Michael Grünewald
# Date: Fri Nov 21 15:38:50 CET 2014

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

PROGRAM=		showconfig.sh

test:
	test -x ${DESTDIR}${BINDIR}/showconfig
	test -f ${DESTDIR}${MANDIR}/man1/showconfig.1.gz

.PATH:			${BSDOWLSRCDIR}/example/script/shell/showconfig

.include "shell.prog.mk"

### End of file `TestProgram.mk'
