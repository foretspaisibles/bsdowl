### bps.autoconf.mk -- Support pour AUTOCONF

# Author: Michaël Le Barbier Grünewald
# Date: Ven 18 avr 2008 09:59:39 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) Michaël Le Barbier Grünewald - 2008-2009
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# CONFIGURE = Makefile.in
# CONFIGURE+= header.in
# .include "bps.autoconf.mk"

### DESCRIPTION

# Si un fichier `configure.ac' ou `configure.in' figure dans notre dossier, ou
# si la variable USE_AUTOCONF est positionnée à `yes' alors les fichiers
# objets associés aux fichiers énumérés dans la variable
# CONFIGURE sont ajoutés aux listes de nettoyage `distclean'.


#
# Description des variables
#

# USE_AUTOCONF
#
#  Contrôle l'utilisation des services du module `bps.autoconf.mk'. Si cette
#  variable n'est pas définie par l'utilisateur et que des traces de
#  l'utilisation d'autoconf par le projet sont trouvées, cette variable est
#  positionnée à `yes'.

# CONFIGURE
#
#  Énumère les sources traitées par le script `configure'. Les fichiers objets
#  produits par `autoconf' correspondant à ces sources sont ajoutés à
#  DISTCLEANFILES.
#
#  Si ils existent, les fichiers `Makefile.in' et `Makefile.inc.in' sont
#  automatiquement ajoutés à cette énumération.

.if !target(__<bps.autoconf.mk>__)
__<bps.autoconf.mk>__:

.if exists(configure.ac)||exists(autoconf.in)
USE_AUTOCONF?=yes
.endif
USE_AUTOCONF?=no
.if ${USE_AUTOCONF} == yes
.for file in config.status config.log
.if exists(${file})
DISTCLEANFILES+= ${file}
.endif
.endfor
.if exists(autom4te.cache)
DISTCLEANDIRS+= autom4te.cache
.endif
CONFIGURE?=
.for file in Makefile.in Makefile.inc.in
.if exists(${file})&&empty(CONFIGURE:M${file})
CONFIGURE+= ${file}
.endif
.endfor
REALCLEANFILES+= ${CONFIGURE:.in=}
.if exists(configure.ac)||exists(configure.in)
.if !defined(REALCLEANFILES)||empty(REALCLEANFILES:Mconfigure)
REALCLEANFILES+= configure
.endif
.endif
.endif # ${USE_AUTOCONF} == yes
.endif # !target(__<bps.autoconf.mk>__)

### End of file `bps.autoconf.mk'
