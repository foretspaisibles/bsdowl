### ocaml.main.mk -- MAIN

# Author: Michael Grünewald
# Date: Mer  1 aoû 2007 09:28:08 CEST
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2006-2009, 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

### DESCRIPTION


.if !target(__<ocaml.main.mk>__)
__<ocaml.main.mk>__:

do-depend:
	${NOP}

do-doc:
	${NOP}

.include "ocaml.source.mk"
.include "ocaml.yacc.mk"
.include "ocaml.lex.mk"
.include "ocaml.object.mk"
.include "ocaml.build.mk"
.include "ocaml.depend.mk"
.include "ocaml.odoc.mk"

.endif # !target(__<ocaml.main.mk>__)

### End of file `ocaml.main.mk'
