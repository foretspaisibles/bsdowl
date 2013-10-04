# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION
### bps.own.mk -- Variables pour les utilisateurs, groupes, permissions ...

# Auteur: Michael Grünewald
# Date: Ven 10 fév 2006 10:40:49 GMT

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

# .include "bps.own.mk"


### DESCRIPTION


# Ce module définit pour ses clients des paramètres pour
# l'installation des objets, soit leur emplacement, leur propiétaire,
# leur groupe et leur droits d'accès.

# Pour les valeurs implictes de ces paramètes, le module distingue le
# cas de l'utilisateur root des autres. Dans le premier cas, il estime
# que `root' souahite installer des programmes pour qu'ils soient
# disponibles pour tous les utilisateurs de la machine, ce qui se
# traduit dans le choix des permissions et de PREFIX, et dans l'autre
# cas il estime que les objets sont destinés à une utilisation privée,
# ce qui est également reflété par les permissions et PREFIX.

# Variable BINDIR BINOWN BINGRP BINMODE
# Ces variables décrivent le site d'accueil BINDIR, le propriétaire
# (BINOWN, BINGRP) et les droits d'accès (BINMODE) pour les objets
# du groupe BIN. Les objets de ce groupe sont des objets binaires
# exécutables, résulat d'un assemblage et d'une édition de liens, ou
# parfois un fichier interprèté (script).
#
# D'autres groupes sont définis dans ce module, soit BIN, SHARE, DOC,
# LIB, dont le nom est semble-t-il assez explicite.
#  Nota: hier(7) définit le type de fichier à placer dans SHAREDIR.
#  SeeAlso: bsd.own.mk, bsd.files.mk, hier(7).


### IMPLÉMENTATION

.if !target(__<bps.own.mk>__)
__<bps.own.mk>__:

.if defined(UID)&&(${UID} == 0)
_OWN_DIRMODE?=	755
_OWN_BINMODE?=	555
_OWN_DTAMODE?=	444
_OWN_OWN?=	${_BPS_SYSTEMOWN}
_OWN_GRP?=	${_BPS_SYSTEMGRP}
.else
_OWN_DIRMODE?=	750
_OWN_BINMODE?=	550
_OWN_DTAMODE?=	440
_OWN_OWN?=	${USER}
_OWN_GRP?=	${GROUP}
.endif

BINDIR?=	${PREFIX}/bin
BINMODE?=	${_OWN_BINMODE}
BINOWN?=	${_OWN_OWN}
BINGRP?=	${_OWN_GRP}

LIBDIR?=	${PREFIX}/lib
LIBMODE?=	${_OWN_DTAMODE}
LIBOWN?=	${_OWN_OWN}
LIBGRP?=	${_OWN_GRP}

SHAREDIR?=	${PREFIX}/share${APPLICATIONDIR}
SHAREMODE?=	${_OWN_DTAMODE}
SHAREOWN?=	${_OWN_OWN}
SHAREGRP?=	${_OWN_GRP}

DOCDIR?=	${PREFIX}/share/doc${APPLICATIONDIR}
DOCMODE?=	${_OWN_DTAMODE}
DOCOWN?=	${_OWN_OWN}
DOCGRP?=	${_OWN_GRP}

.endif #!target(__<bps.own.mk>__)

### End of file `bps.own.mk'
