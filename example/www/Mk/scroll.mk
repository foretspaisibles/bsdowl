### scroll.mk -- A simple static website

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

WWWMAIN?=		main.sgml

SRCS=			main.sgml
SRCS+=			head-css-global.sgml
SRCS+=			more-news.sgml
SRCS+=			copyright-statement.sgml

DIRS=			${SRCDIR}/style
DIRS+=			${SRCDIR}/sgml
DIRS+=			${SRCDIR}/Template

SCROLL_INCLUDE=		head-css-local
SCROLL_INCLUDE+=	more-news
SCROLL_INCLUDE+=	more-ilink
SCROLL_INCLUDE+=	more-elink
SCROLL_INCLUDE+=	more-download

.for include in ${SCROLL_INCLUDE}
.if !empty(SRCS:M${include}.sgml)
SGML_INCLUDE+=		with.${include}
.endif
.endfor

.include "www.sgml.mk"

### End of file `scroll.mk`
