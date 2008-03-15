### ocaml.depend.mk

# Author: Michaël Grünewald
# Date: Sam  7 jul 2007 20:40:59 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

# Copyright (c) 2006, 2007, 2008, Michaël Grünewald
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#    1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#    2. Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#
#    3. The name of the author may not be used to endorse or promote
#    products derived from this software without specific prior written
#    permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.


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
	ocamldep ${.ALLSRC} > .depend

do-clean-depend:
	${RM} -f .depend

.if target(do-depend)
do-depend: .depend
.endif

.if target(do-distclean)
do-distclean: do-clean-depend
.endif

.endif # !target(__<ocaml.depend.mk>__)

### End of file `ocaml.depend.mk'
