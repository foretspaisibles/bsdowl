### bps.own.mk -- Variables pour les utilisateurs, groupes, permissions ...

# Auteur: Michaël Grünewald
# Date: Ven 10 fév 2006 10:40:49 GMT
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
_OWN_OWN?=	root
_OWN_GRP?=	wheel
DESTDIR?=	
PREFIX?=	/usr/local
.else
_OWN_DIRMODE?=	750
_OWN_BINMODE?=	550
_OWN_DTAMODE?=	440
_OWN_OWN?=	${USER}
_OWN_GRP_GOT!=	id -gn
_OWN_GRP?=	${_OWN_GRP_GOT}
DESTDIR?=	
PREFIX?=	${HOME}
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
