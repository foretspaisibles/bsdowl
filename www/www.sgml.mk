### www.sgml.mk -- Prepare a HTML document out of a SGML document

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


### SYNOPSIS

# Attention: This is not a DOCBOOK system!

# WWW=   index.html
#
# SRCS=  index.sgml
# SRCS+= head-css.sgml
# SRCS+= head-title.sgml
# SRCS+= body-content.sgml
# SRCS+= body-nav.sgml
#
# WWWDIR= ${WWWROOTDIR}/subdir
#
# .include "www.sgml.mk"


### DESCRIPTION

# Variables:
#
#
#  WWW [not set]
#   The list of HTML files to produce from SGML sources
#
#    Each member has its own SRCS property and the global SRCS
#    property is appended to it.
#
#
#  WWWMAIN [auto]
#   File used as entry-point for the generation
#
#    When producing several files enumerated in WWW, WWWMAIN should
#    have a property for each file.
#
#    If a file enumerated in WWW has no corresponding property in
#    WWWMAIN and a SGML file can be deduced from his name, this file
#    is used.
#
#
#  WWWROOTDIR
#   Root directory for the WWW hierarchy
#
#    This file is used to automatically define WWWDIR.
#
#
#  WWWOWN, WWWGRP, WWWMODE, WWWDIR
#   Parameters of the file installation procedure
#
#
#  SGML_INCLUDE
#   Enumerate parametrised entities to include
#
#
#  DIRS
#   Enumerate path where file are looked up
#
#   The .CURDIR and .OBJDIR are automatically added to the lookup path
#   and need not to be enumerated by DIRS.
#
#
#  CATALOG
#   Enumerate SGML catalogs


.SUFFIXES: .sgml

WWWNORMALIZE?=		osgmlnorm -d
WWWINPUT?=		ascii
WWWTIDY?=		tidy -q -${WWWINPUT}

.for variable in DIRS CATALOG SGML_INCLUDE
.if defined(${variable})&&!empty(${variable})
.export ${variable}
.else
${variable}=
.endif
.endfor

WWWNORMALIZETOOL=	${WWWNORMALIZE}
.if "${.OBJDIR}" != "${.CURDIR}"
WWWNORMALIZETOOL+=	-D${.OBJDIR}
.endif
WWWNORMALIZETOOL+=	-D${.CURDIR}
.for dir in ${DIRS}
WWWNORMALIZETOOL+=	-D${dir}
.PATH.sgml:		${dir}
.endfor
.for catalog in ${CATALOG}
WWWNORMALIZETOOL+=	-c${catalog}
.endfor
.for include in ${SGML_INCLUDE}
WWWNORMALIZETOOL+=	-i${include}
.endfor

.for file in ${WWW}
.if defined(WWWMAIN)&&!empty(WWWMAIN)
WWWMAIN.${file:T}= ${WWWMAIN}
.endif
.if !defined(WWWMAIN.${file:T}) && exists(${file:.html=.sgml})
WWWMAIN.${file:T}= ${file:.html=.sgml}
.endif
.if !defined(WWWMAIN.${file:T}) || empty(WWWMAIN.${file:T})
.error "No main file for ${file}"
.endif
SRCS.${file:T}?= ${WWWMAIN.${file:T}}
.if empty(SRCS.${file:T}:M${WWWMAIN.${file:T}})
SRCS.${file:T}+= ${WWWMAIN.${file:T}}
.endif
.endfor

.if defined(SRCS)&!empty(SRCS)
.for file in ${WWW}
SRCS.${file:T}+= ${SRCS}
.endfor
.endif

.for file in ${WWW}
CLEANFILES+= ${file}
.if exists(${file}.pre)
CLEANFILES += ${file}.pre
.endif
${file}: ${SRCS.${file:T}}
	${WWWNORMALIZETOOL} ${WWWMAIN.${file:T}} | ${WWWTIDY} > ${.TARGET}.pre
	${MV} ${.TARGET}.pre ${.TARGET}
.endfor

.include "www.files.mk"

### End of file `www.files.mk'
