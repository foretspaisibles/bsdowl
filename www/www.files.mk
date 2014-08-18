### www.files.mk -- A bps.files.mk wrapper for my www

# Author: Michael Grünewald
# Date: Jeu 13 mar 2008 21:58:28 CET
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

# BSD Owl Scripts (https://bitbucket.org/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2014 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# Exemple de fichier maître, placé dans le répertoire principal du
# document WWW à publier (lorsque les fichiers servant à la
# préparation de ce document sont répeartis dans une hiérarchie du
# système de fichiers).
#
# SUBDIR = style
# SUBDIR+= main
#
# # We have to set PREFIX, otherwise the switch credential mechanism
# # will break.
#
# PREFIX = ${HOME}
# WWWBASE = ${PREFIX}/Documents/www
#
# .include "www.files.mk"

# Exemple de fichier subordonné, placé dans l'hypothétique dossier
# ./style.
#
# WWW = classic.css
# WWW+= classic_sz.css
# WWW+= layout.css
# WWW+= modern.css
# WWW+= modern_sz.css
# WWW+= paragraph.css
#
# WWWDIR = ${WWWBASE}/style
#
# .include "www.files.mk"


### DESCRIPTION

# L'assistant de publication de documents WWW fournit une assistance
# pour l'installation des fichiers du document dans le système de
# fichiers local.
#
# Aucune assistance pour la publication sur un système de fichiers
# distant n'est actuellement assurée par ce module, elle peut
# nénamoins être facilement réalisée à parir d'une installation dans
# le système de fichier local.
#
# Si aucune des variables WWWDIR et SUBDIR n'a reçu une valeur, un
# message d'erreur est affiché et le porgramme MAKE se termine.

#
# Description des variables
#

# WWWBASE
#
#   Répertoire racine du document cible (la version installée).
#
#   Lorsque cette variable a une valeur, cette valeur est transmise
#   aux sous-processus MAKE, de cette façon elle peut être utilisée
#   pour définir correctement WWWDIR.

# WWW, WWWOWN, WWWGRP, WWWMODE, WWWDIR
#
#   Paramètres de la procédure d'installation.
#
#   Ces paramètres sont documentés dans le module bps.files.mk.

# SUBDIR
#
#   Liste des sous-dossiers dans lesquels les fichiers du document
#   sont répartis.
#
#   Ce paramètre est utilisé comme pour bps.subdir.mk.

.include "bps.init.mk"

USE_WWW_OWNERSHIP?= no

.if ${USE_WWW_OWNERSHIP} == yes
WWWOWN?= www
WWWGRP?= www
WWWMODE?= 440
.endif

FILESGROUPS+= WWW

.if !defined(WWWDIR) && (!defined(SUBDIR) || empty(SUBDIR))
.error Proper use needs one of the variables WWWDIR or SUBDIR to have a value
.endif

.if empty(.MAKEFLAGS:MWWWBASE)
.if defined(WWWBASE)&&!empty(WWWBASE)
.MAKEFLAGS: WWWBASE='${WWWBASE}'
.endif
.endif

.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"
.include "bps.subdir.mk"

### End of file `www.files.mk'
