#!/bin/sh

# $Id$

echo 'We prepare a new makefile'
read -p 'filename: ' FILENAME
read -p 'comment: ' COMMENT
DATE=`date`

m4 -g\
    -D __FILENAME__="${FILENAME}" \
    -D __COMMENT__="${COMMENT}" \
    -D __DATE__="${DATE}" \
    -D __YEAR__="${YEAR}" \
    > ${FILENAME} <<'EOF'
changecom()dnl
changequote(,)dnl
### __FILENAME__ -- __COMMENT__

# Author: Michaël Le Barbier Grünewald
# Date: __DATE__
# Lang: fr_FR.ISO8859-1

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


### SYNOPSIS

### DESCRIPTION

.if !target(__<__FILENAME__>__)
__<__FILENAME__>__:

.endif # !target(__<__FILENAME__>__)

### End of file `__FILENAME__'
EOF
