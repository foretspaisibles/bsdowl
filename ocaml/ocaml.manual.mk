### ocaml.manual.mk -- Préparation de la référence HTML

# Author: Michaël Le Barbier Grünewald
# Date: Lun 10 mar 2008 11:59:53 CET
# Lang: fr_FR.ISO8859-1

# $Id$

# Copyright (c) 2006, 2007, 2008, 2009 Michaël Le Barbier Grünewald
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

# Ce module permet de préparer une référence HTML à partir de fichiers
# sources contenant des commentaires OCamldoc.

# MANUAL = backend.odoc
# MANUAL+= filter.odoc
#
# SEARCHES = backend_src
# SEARCHES+= filter_src
#
# .include "ocaml.manual.mk"


### DESCRIPTION

# SEARCHES
#  Liste de dossiers à consulter pour trouver les fichiers `odoc'. Les
#   termes de la liste sont exprimés relativement à .OBJDIR.


### RÉALISATION

.include "bps.init.mk"

.if defined(MANUAL)&&!empty(MANUAL)
ODOC_FORMAT = html
.for module in ${MANUAL}
ODOC_LOAD+= ${module}
.endfor

USE_ODOC = yes

.include "ocaml.odoc.mk"
.endif

.include "bps.usertarget.mk"

### End of file `ocaml.manual.mk'
