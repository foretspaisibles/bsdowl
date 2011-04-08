### misc.script.mk -- A makefile to handle scripts

# Auteur: Michaël Grünewald
# Date: Ven 10 fév 2006 10:40:49 GMT
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

# SCRIPT = mp2eps.sh
# SCRIPT+= mp2pdf.sh
# SCRIPT+= mp2png.sh
#
# SCRIPTLIB+= mp2pnglib.sh
#
#
# TMPDIR = /var/run/tmp
#
# SCRIPT_CONFIGURE = PREFIX TMPDIR 
#
# .include "misc.script.mk"


### DESCRIPTION

# Le module fournit des services pour l'installation des scripts. Les
# scripts peuvent faire l'objet d'un prétraitement pour remplacer les
# occurences de certaines variables d'installation par leur valeurs.
#
# Pour bénéficier de cette fonctionnalité, on définit la variable
# SCRIPT_CONFIGURE. Dans l'exemple précédent, les séquences de
# caractères @DESTDIR@ et @TMPDIR@ sont remplacées par leur valeur
# selon make.
#
# La valeur des variables énumérées dans SCRIPT_CONFIGURE ne peut pas
# contenir le caractère `|' (pipe). Comme le suggèrent les exemples,
# cette fonctionnalité est principalement destinée à l'édition de
# paramètres de chemins d'installation, aussi cette restriction est
# sans importance.

.if !target(__<misc.script.mk>__)
__<misc.script.mk>__:

.include "bps.init.mk"

_SCRIPT_EXTS?= pl sh bash py sed awk


# On recalcule la valeur de SCRIPT. Ce n'est pas un très bon style de
# programmation, mais cela permet de présenter à l'utilisateur une
# interface ressemblant à celles des autres modules.

_SCRIPT_DECL:= ${SCRIPT}

.undef SCRIPT
.if defined(SCRIPT)
.error We cannot keep going like this, you should let me undefine\
 the SCRIPT variable.
.endif

SCRIPTMODE?= ${BINMODE}
SCRIPTDIR?= ${BINDIR}
SCRIPTOWN?= ${BINOWN}
SCRIPTGRP?= ${BINGRP}

.if defined(SCRIPT_CONFIGURE)&&!empty(SCRIPT_CONFIGURE)
.for var in ${SCRIPT_CONFIGURE}
_SCRIPT_SED+= -e 's|@${var}@|${${var:S/|/\|/g}}|g'
.endfor
.endif

.for ext in ${_SCRIPT_EXTS}
.for script in ${_SCRIPT_DECL:M*.${ext}}
SCRIPT+= ${script:T:.${ext}=}
.if defined(_SCRIPT_SED)
${script:T:.${ext}=}: ${script}
	${SED} ${_SCRIPT_SED} < ${.ALLSRC} > ${.TARGET}.output
	${MV} ${.TARGET}.output ${.TARGET}
.else
${script:T:.${ext}=}: ${script}
	${CP} ${.ALLSRC} ${.TARGET}
.endif
.endfor
.endfor

# Nous avons recalculé la valeur de SCRIPT. Les fichiers source ne
# figurent pas dans la variable SCRIPT.

CLEANFILES+= ${SCRIPT}
FILESGROUPS+= SCRIPT

#
# Groupe de fichiers SCRIPTLIB
#

# Les membres de ce groupe de fichiers ne sont pas traiter pour le
# remplacement des variables apparaissant dans SCRIPT_CONFIGURE.
SCRIPTLIBMODE?= ${LIBMODE}
SCRIPTLIBDIR?= ${LIBDIR}${APPLICATIONDIR}
SCRIPTLIBOWN?= ${LIBOWN}
SCRIPTLIBGRP?= ${LIBGRP}


.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

.endif #!target(__<misc.script.mk>__)

### End of file `misc.script.mk'
