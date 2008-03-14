### ocaml.odoc.mk -- OCAMLDOC

# Author: Michaël Grünewald
# Date: Dim aoû  5 10:21:05 CEST 2007
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

# do-doc-odoc
# do-clean-odoc


### DESCRIPTION


### XXX

# La valeur implicite de ODOC_SEARCH doit remplacer ${HOME} et
# ${PREFIX} par les sous-dossiers d'installation des fichiers
# ODOC DUMP.

.if !target(__<ocaml.odoc.mk>__)
__<ocaml.odoc.mk>__:

USE_ODOC?= no

.if ${USE_ODOC} == yes

do-doc: do-doc-odoc

ODOC_TITLE?=I am too lazy to set the title
ODOC_INTRO?=
ODOC_FORMAT?=odoc html
ODOC_SORT?=no
ODOC_KEEP_CODE?=no
ODOC_MERGE_INVERSE=?no
ODOC_MERGE?=
ODOC_LOAD?=
ODOC_HIDE?=
ODOC_PREPROCESSOR?=
ODOC_SEARCH?=${DESTDIR}/usr ${DESTDIR}${HOME} ${DESTDIR}${PREFIX}
ODOC_VERBOSE?=no
ODOC_EXCLUDE?=

OCAMLDOC?= ocamldoc

.if defined(APPLICATION)&&!empty(APPLICATION)
ODOC_NAME?=${APPLICATION}
.endif

.if !defined(ODOC_NAME)||empty(ODOC_NAME)
.error The ocaml.odoc.mk module expects ODOC_NAME to be set. A suitable value can also be guessed from the APPLICATION variable value.
.endif

.if defined(SEARCHES)&&!empty(SEARCHES)
ODOC_SEARCH+= ${SEARCHES}
.endif

#
# Calcul des sources
#

.for src in ${_OCAML_SRCS}
.if !empty(${src}:M*.mli)
.for item in ${${src}:M*.mli}
.if empty(_OCAML_SRCS.${ODOC_NAME}:M${item}) && empty(ODOC_EXCLUDE:M${item})
_OCAML_SRCS.${ODOC_NAME}+= ${item}
.endif
.endfor
.endif
.if !empty(${src}:M*.ml)
.for item in ${${src}:M*.ml}
.if empty(_OCAML_SRCS.${ODOC_NAME}:M${item}) && empty(ODOC_EXCLUDE:M${item})
_OCAML_SRCS.${ODOC_NAME}+= ${item}
.endif
.endfor
.for item in ${${src}:M*.ml:.ml=.mli}
.if exists(${item}) && empty(_OCAML_SRCS.${ODOC_NAME}:M${item}) && empty(ODOC_EXCLUDE:M${item})
_OCAML_SRCS.${ODOC_NAME}+= ${item}
.endif
.endfor
.endif
.endfor

#
# Ligne de commande
#

.if defined(_OCAML_SEARCHES)&&!empty(_OCAML_SEARCHES)
_ODOC_FLAGS+=${_OCAML_SEARCHES}
.endif
_ODOC_FLAGS+= -t "${ODOC_TITLE}"
.if !empty(ODOC_INTRO)
_ODOC_FLAGS+= -intro ${ODOC_INTRO}
.endif
.if ${ODOC_VERBOSE} == yes
_ODOC_FLAGS+= -v
.endif
.if ${ODOC_SORT} == yes
_ODOC_FLAGS+= -sort
.endif
.if ${ODOC_KEEP_CODE} == yes
_ODOC_FLAGS+= -keep-code
.endif
.if ${ODOC_MERGE_INVERSE} == yes
_ODOC_FLAGS+= -inv-merge-ml-mli
.endif
.if !empty(ODOC_MERGE)
_ODOC_FLAGS+= -m${ODOC_MERGE}
.endif
.if !empty(ODOC_HIDE)
_ODOC_FLAGS+= -hide ${ODOC_HIDE:Q:S/\\ /,/g}
.endif
.if !empty(ODOC_PREPROCESSOR)
_ODOC_FLAGS+= -pp ${ODOC_PREPROCESSOR}
.endif
.if !empty(ODOC_LOAD)
.for load in ${ODOC_LOAD}
.for path in ${ODOC_SEARCH}
.if exists(${path}/${load})
_ODOC_FLAGS+= -load ${path}/${load}
.endif
.endfor
.endfor
.endif

_ODOC_TOOL=${OCAMLDOC}
.if !empty(_ODOC_FLAGS)
_ODOC_TOOL+=${_ODOC_FLAGS}
.endif

#
# ODOC dump file
#

.if !empty(ODOC_FORMAT:Modoc)

ODOCDIR?= ${DOCDIR}/odoc${APPLICATIONDIR}

ODOC=${ODOC_NAME}.odoc

${ODOC}: ${_OCAML_SRCS.${ODOC_NAME}}
${ODOC}: ${_OCAML_SRCS.${ODOC_NAME}:C/.ml[ily]*/.cmi/}

${ODOC}:
	${_ODOC_TOOL} -dump ${.TARGET} ${_OCAML_SRCS.${ODOC_NAME}}

CLEANFILES+= ${ODOC}

do-doc-odoc: ${ODOC}

do-install-odoc: do-doc-odoc
	${INSTALLDIR} -o ${DOCOWN} -g ${DOCGRP} \
	  ${DESTDIR}${ODOCDIR}
	${INSTALL} -o ${DOCOWN} -g ${DOCGRP} -m ${DOCMODE} \
	  ${ODOC} ${DESTDIR}${ODOCDIR}

.endif # !empty(ODOC_FORMAT:Modoc)

#
# ODOC HTML Generation
#

ODOC_HTMLDIR?= /html
# The place where are installed HTML document under DOCDIR.

.if !empty(ODOC_FORMAT:Mhtml)

ODOC_HTML?= ${ODOC_NAME}_html
do-doc-odoc: ${ODOC_HTML}

${ODOC_HTML}: ${_OCAML_SRCS.${ODOC_NAME}}
${ODOC_HTML}: ${_OCAML_SRCS.${ODOC_NAME}:C/.ml[ily]*/.cmi/}

${ODOC_HTML}:
	${RM} -R -f ${ODOC_HTML}.temp ${ODOC_HTML}
	${MKDIR} ${ODOC_HTML}.temp
	${_ODOC_TOOL} -html -d ${ODOC_HTML}.temp ${_OCAML_SRCS.${ODOC_NAME}}
	${MV} ${ODOC_HTML}.temp ${ODOC_HTML}

do-install: do-install-odoc-html
do-install-odoc-html: do-doc-odoc
	${INSTALL_DIR} -o ${DOCOWN} -g ${DOCGRP} \
	  ${DESTDIR}${DOCDIR}${ODOC_HTMLDIR}
	${INSTALL} -o ${DOCOWN} -g ${DOCGRP} -m ${DOCMODE} \
	  ${ODOC_HTML}/* ${DESTDIR}${DOCDIR}${ODOC_HTMLDIR}


do-clean-odoc: do-clean-odoc-html
do-clean-odoc-html:
	${RM} -R -f ${ODOC_HTML}

.endif # !empty(ODOC_FORMAT:Mhtml)

.if target(do-clean-odoc)
do-clean: do-clean-odoc
.endif

.endif # USE_ODOC

.endif # !target(__<ocaml.odoc.mk>__)

### End of file `ocaml.odoc.mk'
