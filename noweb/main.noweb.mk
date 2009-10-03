### main.noweb.mk -- Routines pour NOWEB

# Author: Michaël Le Barbier Grünewald
# Date: Sam  3 oct 2009 19:10:53 CEST
# Lang: fr_FR.ISO8859-15

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) Michaël Le Barbier Grünewald - 2009
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


# SYNOPSIS
#
# NOTANGLE = code1.c
# NOTANGLE+= code1.h
# NOTANGLE+= code2.c
#
# NOWEAVE = document
# NOWEAVE_DEVICE = latex html
#
# NOWEB = source1.nw
# NOWEB+= source2.nw
#
# .include "bps.noweb.mk"

# DESCRIPTION
#
# Le module `bps.noweb.mk' fournit un service pour utiliser l'outil de
# programmtion lettrée NOWEB dans un projet. Les fonctionnalités de ce module
# sont de bas niveau et il peut-être utilisé à bon escient dans des modules
# plus sophistiqués.

#
# Description des variables
#

# NOWEB
#
#  Énumère les fichiers noweb.
#
#  Cette liste des fichiers est utilisée comme argument aux programmes noweave
#  et notangle. Pour chacun de ces fichiers des paramètres individuels peuvent
#  être définis.

# NOTANGLE
#
#  Énumère la liste des fichiers devant être produits par notangle.

# NOWEAVE
#
#  Fichier devant être produit par noweave.

# NOTANGLE_LINE_HINTS
#
#  Format des indications de numéro de ligne par notangle.

# NOTANGLE_TABS
#
#  Largeur d'une tabulation.
#
#  Si cette variable est définie, notangle utilise des tabulations pour
#  présenter le code, et utilise la valeur de cette variable comme largeur
#  des tabulations.

# NOTANGLE_FILTER
#
#  Énumère la liste des filtres utilisés par notangle.

# NOTANGLE_MARKUP
#
#  Analyseur syntaxique à utiliser sur les fichiers sources.
#
#  Si cette variable est définie, sa valeur est un programme que notangle
#  utilise pour filtrer les sources avant de les traiter.

# NOWEAVE_CHUNKS
#
#  Format utilisé pour les bouts de documentation dans les fichiers noweb.
#
#  Valeurs autorisées: tex, latex, troff, custom

# NOWEAVE_DEVICE
#
#  Énumère les formats des fichiers de documentation à produire.
#
#  Cette énumération peut contenir les termes:
#   texte, tex, latex, troff, html.

# NOWEAVE_FILTER
#
#  Énumère les filtres que noweave doit utiliser.

# NOWEAVE_MARKUP
#
#  Analyseur syntaxique utilisé dans le prétraitement des fichiers noweb.

# NOWEAVE_INDEX
#
#  Drapeau contrôlant la production d'un index.
#
#  Ce drapeau n'est pris en compte que pour la production de la documentation
#  au format HTML ou LaTeX.

# NOWEAVE_AUTODEFS
#
#  Langage pour lequel les définitions doivent être devinées.

# NOWEAVE_HTML_CSS
#
#  Feuille de style CSS

# NOWEAVE_LATEX_WRAPPER (yes)
#
#  Drapeau contrôlant l'utilisation du `wrapper' noweave
#
#  Si la valeur de cette variable est `yes', noweave ajoute lui-même un
#  préambule minimal à sa sortie. Si la valeur de cette variable est `delay'
#  alors noweave est appelé avec l'option `delay'.
#
#  Les variables `NOWEAVE_LATEX_*' définies ci-dessous permettent de modifier
#  le document LaTeX dans de petites proportions. Pour toutes les situations
#  un tant soit peu complexes, et notamment la production d'une page HTML et
#  d'un document LaTeX à partir d'une même source, l'emploi de ces variables
#  sont à éviter, il faut lui préférer `NOWEAVE_LATEX_WRAPPER=delay'.

# NOWEAVE_LATEX_DEFS
#
#  Fichiers contenant des définitions l2h
#
#  Les fichiers LaTeX dont les nom sont donnés par cette variable sont filtrés
#  pour retenir les définitions l2h qu'il contient et ajouté en tête de la
#  liste des fichiers traités par noweave.
#
#  Le produit du fichier filtré est l2h.defs.

# NOWEAVE_LATEX_OPTION
#
#  Énumère les options passées au package LaTeX de noweb.

# NOWEAVE_LATEX_PAGENO
#
#  Drapeau contrôlant la marque des chunks par les numéros de page.
#
#  Ce drapeau contrôle l'option `-x' de noweave.

# NOWEAVE_LATEX_SIMPLIFY
#
#  Filtre simplifiant un fichier LaTeX pour l2h

# NOWEAVE_LATEX_DOCUMENTCLASS
#
#  Classe de document à utiliser au lieu de `article'
#
#  Note: cette variable n'a d'effet que si NOWEAVE_LATEX_WRAPPER est `yes'.

# NOWEAVE_LATEX_PREAMBLE
#
#  Préambule à insérer au début d'un document LaTeX
#
#  Si la valeur de cette variable est un nom de fichier, alors le contenu de
#  ce fichier est utilisé comme préambule, sinon, la valeur est directement
#  insérée dans le préambule.
#
#  Note: cette variable n'a d'effet que si NOWEAVE_LATEX_WRAPPER est `yes'.

# _NOWEAVE_DEVICE.filter.<device>
#
#  Premier filtre utilisé pour produire le fichier de document <device>.

# _NOWEAVE_DEVICE.suffix.<device>
#
#  Nom du suffixe utlisé pour produire le fichier de document <device>.


### IMPLÉMENTATION

.if !target(__<bps.noweb.mk>__)
__<bps.noweb.mk>__:

.SUFFIXES: .nw

NOWEAVE_DEVICE?= latex html
NOWEAVE_CHUNKS?= latex
NOWEAVE_INDEX?= yes
NOWEAVE_LATEX_WRAPPER?= yes
NOWEAVE_LATEX_DEFS?=
NOWEAVE_LATEX_DEFS_FILE?= l2h.defs

_NOTANGLE_TOOL?= notangle
_NOWEAVE_TOOL?= noweave
_NOWEAVE_SED?=

_NOWEAVE_CHUNKS = tex latex troff custom
_NOWEAVE_DEVICES = texte tex latex troff html

_NOTANGLE_VARS = NOWEB
_NOTANGLE_VARS+= NOTANGLE_LINE_HINTS
_NOTANGLE_VARS+= NOTANGLE_FILTER
_NOTANGLE_VARS+= NOTANGLE_MARKUP
_NOTANGLE_VARS+= _NOTANGLE_TOOL

_NOWEAVE_VARS = NOWEB
_NOWEAVE_VARS+= NOWEAVE_FILTER
_NOWEAVE_VARS+= NOWEAVE_MARKUP
_NOWEAVE_VARS+= NOWEAVE_INDEX
_NOWEAVE_VARS+= NOWEAVE_AUTODEFS
_NOWEAVE_VARS+= _NOWEAVE_TOOL

.for device in ${_NOWEAVE_DEVICES}
_NOWEAVE_VARS+= _NOWEAVE_SED.${device}
.endfor

.for device in ${_NOWEAVE_DEVICES}
_NOWEAVE_SED.${device}?= ${_NOWEAVE_SED}
.endfor

_NOWEAVE_FILTER.tex.tex?=
_NOWEAVE_FILTER.latex.latex?=
.if defined(NOWEAVE_LATEX_SIMPLIFY)&&!empty(NOWEAVE_LATEX_SIMPLIFY)
_NOWEAVE_FILTER.latex.html?= '${NOWEAVE_LATEX_SIMPLIFY:S/'/'\''/g} | l2h'
# Fool Emacs'
.else
_NOWEAVE_FILTER.latex.html?= l2h
.endif
_NOWEAVE_FILTER.troff.troff?=

.for chunk in ${_NOWEAVE_CHUNKS}
.for device in ${_NOWEAVE_DEVICES}
_NOWEAVE_FILTER.${chunk}.${device}?= no
.endfor
.endfor

_NOWEAVE_DEVICE.suffix.texte = .text
_NOWEAVE_DEVICE.suffix.tex = .tex
_NOWEAVE_DEVICE.suffix.latex = .tex
_NOWEAVE_DEVICE.suffix.troff = .mm
_NOWEAVE_DEVICE.suffix.html = .html

_NOWEAVE_DEVICE.flag.texte = -n -tex
_NOWEAVE_DEVICE.flag.tex = -tex
_NOWEAVE_DEVICE.flag.latex = -latex
_NOWEAVE_DEVICE.flag.troff = -troff
_NOWEAVE_DEVICE.flag.html = -html

.for device in ${_NOWEAVE_DEVICES}
_NOWEAVE_DEVICE.filter.${device} = ${_NOWEAVE_FILTER.${NOWEAVE_CHUNKS}.${device}}
.endfor

.for tool in NOTANGLE NOWEAVE
.for var in ${_${tool}_VARS}
${var}?=
.endfor
.endfor

#
# Préparation des outils
#


.if defined(NOTANGLE_LINE_HINTS)&&!empty(NOTANGLE_LINE_HINTS)
_NOTANGLE_TOOL+= -L$'{NOTANGLE_LINE_HINTS}'
.endif

.if defined(NOTANGLE_TABS)&&!empty(NOTANGLE_TABS)
.if ${_NOTANGLE_TABS} == yes
_NOTANGLE_TOOL+= -t
.else
_NOTANGLE_TOOL+= -t${NOTANGLE_TABS}
.endif
.endif


#
# Spécialisation des variables
#

.for tool in NOTANGLE NOWEAVE
.for var in ${_${tool}_VARS}
.for file in ${${tool}}
.if !defined(${var}.${file:T})
${var}.${file:T}?= ${${var}}
.endif
.endfor
.endfor
.endfor

#
# Tangling
#

.for file in ${NOTANGLE}
.if defined(NOTANGLE_MARKUP.${file:T})&&!empty(NOTANGLE_MARKUP.${file:T})
_NOTANGLE_TOOL.${file:T}+= -markup ${NOTANGLE_MARKUP.${file:T}}
.endif
.if defined(NOTANGLE_FILTER.${file:T})&&!empty(NOTANGLE_FILTER.${file:T})
_NOTANGLE_TOOL.${file:T}+= ${NOTANGLE_FILTER.${file:T}:C/^/-filter /g}
.endif
CLEANFILES+= ${file}
${file}: ${NOWEB.${file:T}}
	${_NOTANGLE_TOOL.${file:T}} -R${.TARGET} ${.ALLSRC} | cpif ${.TARGET}
.endfor

#
# Weaving
#


# Préparation des outils

.for file in ${NOWEAVE}
.for device in ${NOWEAVE_DEVICE}
_NOWEAVE_TOOL.${device}.${file:T}?= ${_NOWEAVE_TOOL.${file:T}}
_NOWEAVE_TOOL.${device}.${file:T}+= ${_NOWEAVE_DEVICE.flag.${device}}
.if defined(NOWEAVE_MARKUP.${file:T})&&!empty(NOWEAVE_MARKUP.${file:T})
_NOWEAVE_TOOL.${device}.${file:T}+= -markup ${NOWEAVE_MARKUP.${file:T}}
.endif
.if defined(NOWEAVE_FILTER.${file:T})&&!empty(NOWEAVE_FILTER.${file:T})
_NOWEAVE_TOOL.${device}.${file:T}+= ${NOWEAVE_FILTER.${file:T}:C/^/-filter /g}
.endif
.if defined(_NOWEAVE_DEVICE.filter.${device})&&!empty(_NOWEAVE_DEVICE.filter.${device})
_NOWEAVE_TOOL.${device}.${file:T}+= -filter ${_NOWEAVE_DEVICE.filter.${device}}
.endif
.endfor
.endfor


# Préparation spécifique à LaTeX

.if !empty(NOWEAVE_DEVICE:Mlatex)
.if ${NOWEAVE_LATEX_WRAPPER} == yes
.if defined(NOWEAVE_LATEX_PREAMBLE)&&!empty(NOWEAVE_LATEX_PREAMBLE)
.if exists(${NOWEAVE_LATEX_PREAMBLE})
_NOWEB.latex_preamble!= tr -d '\n' < ${NOWEAVE_LATEX_PREAMBLE}
.else
_NOWEB.latex_preamble!= printf "%s" "${NOWEAVE_LATEX_PREAMBLE}" | tr -d '\n'
.endif
.endif
.for file in ${NOWEAVE}
.if defined(NOWEAVE_LATEX_PREAMBLE)&&!empty(NOWEAVE_LATEX_PREAMBLE)
_NOWEAVE_SED.latex.${file:T}+= -e '1s/^\\documentclass{article}/\\documentclass{article}${_NOWEB.latex_preamble:S%\\%\\\\%g}/'
.endif
.if defined(NOWEAVE_LATEX_DOCUMENTCLASS)&&!empty(NOWEAVE_LATEX_DOCUMENTCLASS)
_NOWEAVE_SED.latex.${file:T}+= -e '1s/^\\documentclass{article}/\\documentclass{${NOWEAVE_LATEX_DOCUMENTCLASS}}/'
.endif
.endfor
.elif ${NOWEAVE_LATEX_WRAPPER} == delay
.for file in ${NOWEAVE}
_NOWEAVE_TOOL.latex.${file:T}+= -delay
.endfor
.else # ${NOWEAVE_LATEX_WRAPPER} == yes || delay
.for file in ${NOWEAVE}
_NOWEAVE_TOOL.latex.${file:T}+= -n
.endfor
.endif
.endif #!empty(NOWEAVE_DEVICE:Mlatex)

# Préparation spécifique à html

.if !empty(NOWEAVE_DEVICE:Mhtml)
.if defined(NOWEAVE_LATEX_DEFS)&&!empty(NOWEAVE_LATEX_DEFS)
CLEANFILES+= ${NOWEAVE_LATEX_DEFS_FILE}
${NOWEAVE_LATEX_DEFS_FILE}: ${NOWEAVE_LATEX_DEFS}
	grep '^% l2h ' ${.ALLSRC} | cpif ${.TARGET}
.for file in ${NOWEAVE}
${file}${_NOWEAVE_DEVICE.suffix.html}: ${NOWEAVE_LATEX_DEFS_FILE}
.endfor
.endif
.endif

#
# Index et autodefs
#
.for file in ${NOWEAVE}
.for device in ${NOWEAVE_DEVICE:Nlatex}
.if ${NOWEAVE_INDEX.${file:T}} == yes
_NOWEAVE_TOOL.${device}.${file:T}+= -index
.endif
.endfor
.for device in ${NOWEAVE_DEVICE:Mlatex}
.if ${NOWEAVE_INDEX.${file:T}} == yes && !(${NOWEAVE_LATEX_WRAPPER} == delay)
_NOWEAVE_TOOL.${device}.${file:T}+= -index
.endif
.endfor
.endfor

.for file in ${NOWEAVE}
.for device in ${NOWEAVE_DEVICE}
.if defined(NOWEAVE_AUTODEFS.${file:T})&&!empty(NOWEAVE_AUTODEFS.${file:T})
_NOWEAVE_TOOL.${device}.${file:T}+= -autodefs ${NOWEAVE_AUTODEFS.${file:T}}
.endif
.endfor
.endfor

.for file in ${NOWEAVE}
.for device in ${NOWEAVE_DEVICE}
_NOWEAVE_CMD.${device}.${file} = ${_NOWEAVE_TOOL.${device}.${file:T}}
_NOWEAVE_CMD.${device}.${file}+= ${.ALLSRC}
#
# Préparations spéciales pour HTML
#
.if ${_NOWEAVE_DEVICES:M${device}} == html
_NOWEAVE_CMD.${device}.${file}+= | htmltoc
_NOWEAVE_SED.${device}.${file}+= -e 's%^<tableofcontents>$$%<div id="tableofcontents">%'
_NOWEAVE_SED.${device}.${file}+= -e 's%^</tableofcontents>$$%</div>%'
.if defined(NOWEAVE_HTML_CSS)&&!empty(NOWEAVE_HTML_CSS)
_NOWEAVE_SED.${device}.${file}+= -e '2s%</head>%<link rel="stylesheet" title="Classic" type="text/css" href="${NOWEAVE_HTML_CSS}" /></head>%'
.endif
.endif
.if !empty(_NOWEAVE_SED.${device}.${file:T})
_NOWEAVE_CMD.${device}.${file}+= | sed ${_NOWEAVE_SED.${device}.${file:T}}
.endif
_NOWEAVE_CMD.${device}.${file}+= | cpif ${.TARGET}
CLEANFILES+= ${file}${_NOWEAVE_DEVICE.suffix.${device}}
${file}${_NOWEAVE_DEVICE.suffix.${device}}: ${NOWEB.${file:T}}
	${_NOWEAVE_CMD.${device}.${file}}
.endfor
.endfor

.endif #!target(__<bps.noweb.mk>__)
