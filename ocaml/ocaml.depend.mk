### ocaml.depend.mk

# Author: Michaël Le Barbier Grünewald
# Date: Sam  7 jul 2007 20:40:59 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
# 
# Copyright (C) Michaël Le Barbier Grünewald - 2006-2009
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

# Ce module installe peut-être une cible do-depend pour générer les
# listes de dépendances. Il installe une cible do-clean-depend pour
# détruire ce fichier. Il installe peut-être une dépendance
# do-clean: do-clean-depend (si do-clean existe).


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
	ocamldep ${.ALLSRC} > ${.TARGET}

DISTCLEANFILES+= .depend

.if target(do-depend)
do-depend: .depend
.endif

.endif # !target(__<ocaml.depend.mk>__)

### End of file `ocaml.depend.mk'
