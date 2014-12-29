### ocaml.odoc.mk -- Simple interface to OCamldoc

# Author: Michael Grünewald
# Date: Sun Aug  5 10:21:05 CEST 2007

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
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

# USE_ODOC=		yes
#
# ODOC_NAME=		uname
# _OCAML_SRCS.${ODOC_NAME}=file_a.mli file_b.mli
#
# .include "ocaml.odoc.mk"


### DESCRIPTION

# This simple interface with OCamldoc allows to produce documentation
# dump files or a HTML manual.
#
# This module is intended to be included by other modules rather than
# to serve as is to the end user. (See ocaml.manual.mk for a
# module producing HTML documentation.)

# Targets:
#
# do-doc-odoc
# do-install-odoc
# do-clean-odoc

# Variables:
#
#
#  ODOC_NAME
#   UNIX file name used to label objects
#
#   This defaults to ${LIBRARY} or ${PACKAGE} if one of these
#   variables is defined.
#
#
#  ODOC_DIRS
#   Lookup path for dump files
#
#   Relative paths are interpreted from ${.OBJDIR}. If this variable
#   is uninitalized but the variable DIRS is, it receives the
#   value of DIRS.
#
#
#  ODOC_LOAD
#   List of dump files to load
#
#
#  ODOC_HIDE [not set]
#   List of modules to hide
#
#
#  ODOC_SORT [no]
#   Flag governing the sorting of the module list
#
#
#  ODOC_KEEP_CODE [no]
#   Flag governing the keep of the code
#
#
#  ODOC_MERGE_INVERSE [no]
#   Flag governing the merge order inversion
#
#
#  ODOC_INSTALL_DUMPS
#   Flag governing the installation of the dumps
#
#   If this is set to yes, then ocamldoc dump files for the
#   documentation are installed along the documentation and can be
#   used in another job.  See the variables ODOC_DIRS and ODOC_LOAD.
#
#
#  ODOC_EXCLUDE
#   List of modules to exclude
#
#
#  ODOC_HTML_CSS_FILE
#   CSS file to use for the HTML output
#
#   This file is copied in the HTML directory output.
#
#
#  ODOC_HTML_CSS_URL
#   CSS name to use for the HTML output
#
#   This URL is written in the relevant files, but the module does not
#   take any action to make this URL available.
#
#
#  ODOC_HTML_INTRO
#   Intro name to the use for the HTML output
#
#   This file is pasted in the HTML output.
#
#
#  ODOC_HTML_CHARSET
#   Advertise the charset used in input files and the HTML output.
#
#   Examples: iso-8859-1, iso-8859-15, utf-8.
#
#
#  ODOC_SHORT_FUNCTORS
#   Use the short functor notation


### IMPLEMENTATION

.if !defined(THISMODULE)
.error ocaml.odoc.mk cannot be included directly.
.endif

.if !target(__<ocaml.odoc.mk>__)
__<ocaml.odoc.mk>__:

.if !empty(_USES_OPTIONS:Mocamldoc)
USE_ODOC=		yes
.for format in odoc html
.if !empty(_USES_ocamldoc_ARGS:M${format})
ODOC_FORMAT+=		${format}
.endif
.endfor
.endif

.if !empty(_MODULE_LIST:Mocaml.manual)&&(${THISMODULE} == ocaml.lib)
USE_ODOC?=		yes
.if empty(ODOC_FORMAT:Modoc)
ODOC_FORMAT+=		odoc
.endif
.endif

USE_ODOC?=		no

.if ${USE_ODOC} == yes

do-doc: do-doc-odoc

ODOC_TITLE?=		I am too lazy to set the title
ODOC_INTRO?=
ODOC_FORMAT?=		odoc html
ODOC_SORT?=		no
ODOC_KEEP_CODE?=	no
ODOC_MERGE_INVERSE=?	no
ODOC_MERGE?=
ODOC_LOAD?=
ODOC_HIDE?=
ODOC_PREPROCESSOR?=
ODOC_DIRS?=
ODOC_VERBOSE?=		no
ODOC_EXCLUDE?=
ODOC_INSTALL_DUMPS?=	no
ODOC_SHORT_FUNCTORS?=	yes

OCAMLDOC?=		ocamldoc

.if defined(LIBRARY)&&!empty(LIBRARY)
ODOC_NAME?=		${LIBRARY}
.endif

.if defined(PACKAGE)&&!empty(PACKAGE)
ODOC_NAME?=		${PACKAGE}
.endif

.if !defined(ODOC_NAME)||empty(ODOC_NAME)
.error The ocaml.odoc.mk module expects ODOC_NAME to be set.\
	A suitable value could also be guessed from the PACKAGE\
	variable value, but you did not provide one.
.endif

.if defined(DIRS)&&!empty(DIRS)
ODOC_DIRS+=		${DIRS}
.endif

_OCAML_SRCS.${ODOC_NAME}?=

#
# Computing sources
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
.if !empty(${src}:M*.mll)
.for item in ${${src}:M*.mll:.mll=.mli}
.if exists(${item})
_OCAML_SRCS.${ODOC_NAME}+= ${item}
.endif
.endfor
.endif
.endfor

#
# Building the command line
#

.if defined(_OCAML_DIRS)&&!empty(_OCAML_DIRS)
_ODOC_FLAGS+=${_OCAML_DIRS}
.endif
_ODOC_FLAGS+=-t "${ODOC_TITLE}"
.if !empty(ODOC_INTRO)
_ODOC_FLAGS+=-intro ${ODOC_INTRO}
.endif
.if ${ODOC_VERBOSE} == yes
_ODOC_FLAGS+=-v
.endif
.if ${ODOC_SHORT_FUNCTORS} == yes
_ODOC_FLAGS+=-short-functors
.endif
.if ${ODOC_SORT} == yes
_ODOC_FLAGS+=-sort
.endif
.if ${ODOC_KEEP_CODE} == yes
_ODOC_FLAGS+=-keep-code
.endif
.if ${ODOC_MERGE_INVERSE} == yes
_ODOC_FLAGS+=-inv-merge-ml-mli
.endif
.if !empty(ODOC_MERGE)
_ODOC_FLAGS+=-m${ODOC_MERGE}
.endif
.if !empty(ODOC_HIDE)
_ODOC_FLAGS+=-hide ${ODOC_HIDE:Q:S/\\ /,/g}
.endif
.if !empty(ODOC_PREPROCESSOR)
_ODOC_FLAGS+=-pp ${ODOC_PREPROCESSOR}
.endif
.if !empty(ODOC_LOAD)
.SUFFIXES: .odoc
.PATH.odoc: ${ODOC_DIRS}
_ODOC_FLAGS+=${.ALLSRC:M*.odoc:S/^/-load /}
.endif

_ODOC_TOOL=${OCAMLDOC}
.if !empty(_ODOC_FLAGS)
_ODOC_TOOL+=${_ODOC_FLAGS}
.endif

#
# Handling ocaml dump files
#

.if !empty(ODOC_FORMAT:Modoc)

ODOCDIR?=		${DOCDIR}/odoc

ODOC=			${ODOC_NAME}.odoc

PRODUCT+=		${ODOC}

do-product: do-product-odoc
do-product-odoc:
	@${PRODUCTTOOL} '${ODOC}' ''

.if !empty(ODOC_LOAD)
${ODOC_HTML}: ${ODOC_LOAD}
.endif
${ODOC}: ${_OCAML_SRCS.${ODOC_NAME}}
${ODOC}: ${_OCAML_SRCS.${ODOC_NAME}:C/.ml[ily]*/.cmi/}

${ODOC}:
	${_ODOC_TOOL} -dump ${.TARGET} ${.ALLSRC:N*.cmi:N*.odoc}

CLEANFILES+= ${ODOC}

do-doc-odoc: ${ODOC}

.if ${ODOC_INSTALL_DUMPS} == yes
do-install-odoc: do-doc-odoc
	${INSTALL_DIR} -o ${DOCOWN} -g ${DOCGRP}\
	  ${DESTDIR}${ODOCDIR}
	${INSTALL} -o ${DOCOWN} -g ${DOCGRP} -m ${DOCMODE}\
	  ${ODOC} ${DESTDIR}${ODOCDIR}
.endif

.endif # !empty(ODOC_FORMAT:Modoc)

#
# Handling ocaml doc HTML documentation
#

ODOC_HTMLDIR?=		/html
# The place where are installed HTML document under DOCDIR.

.if !empty(ODOC_FORMAT:Mhtml)

ODOC_HTML?=		${ODOC_NAME}_html
ODOC_HTML_INTRO?=
ODOC_HTML_CHARSET?=

_ODOC_HTML_TOOL?=	${_ODOC_TOOL} -html

.if defined(ODOC_HTML_CHARSET)&&!empty(ODOC_HTML_CHARSET)
_ODOC_HTML_TOOL+=-charset ${ODOC_HTML_CHARSET}
.endif

.if defined(ODOC_HTML_CSS_URL)&&!empty(ODOC_HTML_CSS_URL)
_ODOC_HTML_TOOL+=-css-style ${ODOC_HTML_CSS_URL}
.endif

.if defined(ODOC_HTML_CSS_FILE)&&!empty(ODOC_HTML_CSS_FILE)
${ODOC_HTML}: ${ODOC_HTML_CSS_FILE}
.endif

.if defined(ODOC_HTML_INTRO)&&!empty(ODOC_HTML_INTRO)
${ODOC_HTML}: ${ODOC_HTML_INTRO}
_ODOC_HTML_TOOL+=-intro ${.ALLSRC:M*${ODOC_HTML_INTRO}}
.endif

do-doc-odoc: ${ODOC_HTML}

.if !empty(ODOC_LOAD)
${ODOC_HTML}: ${ODOC_LOAD}
.endif
${ODOC_HTML}: ${_OCAML_SRCS.${ODOC_NAME}}
${ODOC_HTML}: ${_OCAML_SRCS.${ODOC_NAME}:C/.ml[ily]*$/.cmi/}

${ODOC_HTML}:
	${RM} -R -f ${ODOC_HTML}.temp ${ODOC_HTML}
	${MKDIR} ${ODOC_HTML}.temp
	${_ODOC_HTML_TOOL} -d ${ODOC_HTML}.temp\
	  ${.ALLSRC:N*.cmi:N*.odoc:N*.text:N*.css}
.if defined(ODOC_HTML_CSS_FILE)&&!empty(ODOC_HTML_CSS_FILE)
	${CP} ${.ALLSRC:M*${ODOC_HTML_CSS_FILE}} ${ODOC_HTML}.temp/style.css
.endif
	${MV} ${ODOC_HTML}.temp ${ODOC_HTML}

do-install-odoc: do-install-odoc-html
do-install-odoc-html: do-doc-odoc
	${INSTALL_DIR} -o ${DOCOWN} -g ${DOCGRP}\
	  ${DESTDIR}${DOCDIR}${ODOC_HTMLDIR}
	(cd ${ODOC_HTML} &&\
	  ${COPYTREE_DOC} . ${DESTDIR}${DOCDIR}${ODOC_HTMLDIR})

do-clean-odoc: do-clean-odoc-html
do-clean-odoc-html:
	${RM} -R -f ${ODOC_HTML}

.endif # !empty(ODOC_FORMAT:Mhtml)


.if target(do-install-odoc)
do-install: do-install-odoc
.endif

.if target(do-clean-odoc)
do-clean: do-clean-odoc
.endif

.endif # USE_ODOC

.endif # !target(__<ocaml.odoc.mk>__)

### End of file `ocaml.odoc.mk'
