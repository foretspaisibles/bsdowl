### misc.script.mk -- A makefile to handle scripts

# Auteur: Michaël Grünewald
# Date: Ven 10 fév 2006 10:40:49 GMT
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

# SCRIPT = mp2eps.sh
# SCRIPT+= mp2pdf.sh
# SCRIPT+= mp2png.sh
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

_SCRIPT_EXTS?= pl sh bash py


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

.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

.endif #!target(__<misc.script.mk>__)

### End of file `misc.script.mk'
