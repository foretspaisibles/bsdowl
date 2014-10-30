### ocaml.main.mk -- Main common file

# Author: Michael Grünewald
# Date: Wed Aug  1 09:28:08 CEST 2007

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


### SYNOPSIS

# .include "ocaml.main.mk"


### DESCRIPTION

# This would-be mean file has for only job to define one entry point
# slurping many other simpler files.  It is an important node in the
# hierarchy but nothing per se.
#
# This module is intended to be included by other modules rather than
# to serve as is to the end user.

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
