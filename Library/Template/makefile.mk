#!/bin/sh

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

# Author: Michael Grünewald
# Date: __DATE__
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

### DESCRIPTION

.if !target(__<__FILENAME__>__)
__<__FILENAME__>__:

.endif # !target(__<__FILENAME__>__)

### End of file `__FILENAME__'
EOF
