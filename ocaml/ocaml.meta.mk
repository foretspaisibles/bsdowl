### ocaml.meta.mk -- Fichiers META pour ocamlfind

# Author: Michaël Le Barbier Grünewald
# Date: Mer 30 jui 2010 16:02:10 CEST
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

# LIBDIR?= ${PREFIX}/lib/ocaml/site-lib${APPLICATIONDIR}
# .include "ocaml.meta.mk"


### DESCRIPTION

# Ce module définit un groupe pour l'installation d'un fichier META,
# pour le programme ocamlfind.

.if !target(__<ocaml.meta.mk>__)
__<ocaml.meta.mk>__:

.include "bps.init.mk"
.include "ocaml.init.mk"

FILESGROUPS+= META

METAOWN?= ${LIBOWN}
METAGRP?= ${LIBGRP}
METADIR?= ${LIBDIR}
METAMODE?= ${LIBMODE}
METANAME?= META

.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

.endif #!target(__<ocaml.meta.mk>__)

### End of file `ocaml.meta.mk'
