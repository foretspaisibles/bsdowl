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

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


### SYNOPSIS

### DESCRIPTION

.if !target(__<__FILENAME__>__)
__<__FILENAME__>__:

.endif # !target(__<__FILENAME__>__)

### End of file `__FILENAME__'
EOF
