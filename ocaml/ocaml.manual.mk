### ocaml.manual.mk -- Préparation des manuels

# Author: Michaël Grünewald
# Date: Lun 10 mar 2008 11:59:53 CET
# Lang: fr_FR.ISO8859-1

# $Id$

# Copyright (c) 2008, Michaël Grünewald
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

# MANUAL = backend.odoc
# MANUAL+= filter.odoc
#
# SEARCHES = backend_src
# SEARCHES+= filter_src

# Produire un manuel de référence à partir de backend.doc et de
# filter.doc.


.include "make.init.mk"

.if defined(MANUAL)&&!empty(MANUAL)
ODOC_FORMAT = html
.for module in ${MANUAL}
ODOC_LOAD = ${module}
.endfor

USE_ODOC = yes

.include "ocaml.odoc.mk"
.endif

.include "make.usertarget.mk"

### End of file `ocaml.manual.mk'
