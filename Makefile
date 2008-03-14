### Makefile

# Author: Michaël Grünewald
# Date: Ven 10 fév 2006 16:50:40 GMT
# Lang: fr_FR.ISO8859-1

# $Id$

SUBDIR+=	make
SUBDIR+=	ocaml
SUBDIR+=	text
SUBDIR+=	rox

.MAKEFLAGS:	-I ${.CURDIR}/Library/Make

.include "subdir.mk"

### End of file `Makefile'
