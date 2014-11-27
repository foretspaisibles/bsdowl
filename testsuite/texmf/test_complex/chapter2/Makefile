### Makefile -- Produce the chapter 2 of our complex document

# Author: Michael Grünewald
# Date: Sun Nov 23 22:24:32 CET 2014

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

DOCUMENT=		galley

SRCS=			galley.tex
SRCS+=			preamble.tex
SRCS+=			chapter2.tex
SRCS+=			square.mp
SRCS+=			table.tex

TEXINPUTS=		${SRCDIR}/macro

table.tex:		table.d
	${AWK} -f ${.CURDIR}/maketable.awk < ${.ALLSRC} > ${.TARGET}\
	  || (${RM} ${.TARGET}; exit 1)

REALCLEANFILES+=	table.tex

.include "latex.doc.mk"

### End of file `Makefile'
