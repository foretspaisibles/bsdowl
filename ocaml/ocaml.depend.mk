### ocaml.depend.mk

# Author: Michael Grünewald
# Date: Sam  7 jul 2007 20:40:59 CEST

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2006-2013, 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# .depend: module1.ml
# .depend: module1.mli
# .depend: module2.mly
# .depend: module3.mll
# .include "ocaml.depend.mk"


### DESCRIPTION

# Targets:
# do-depend
# do-clean-depend

# Variables:

.if !target(__<ocaml.depend.mk>__)
__<ocaml.depend.mk>__:

.for thg in ${_OCAML_SRCS}
.for item in ${${thg}}
.depend: ${item:C/.ml[ly]/.ml/}
.if exists(${item:.ml=.mli})
.depend: ${item:.ml=.mli}
.endif
.endfor
.endfor

.depend:
	ocamldep ${MLDEPFLAGS} ${.ALLSRC} > ${.TARGET}

REALCLEANFILES+= .depend

.if target(do-depend)
do-depend: .depend
.endif

.endif # !target(__<ocaml.depend.mk>__)

### End of file `ocaml.depend.mk'
