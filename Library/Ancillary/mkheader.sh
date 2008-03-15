### mkheader.sh -- Prépare un en-tête pour un fichier Makefile

# Author: Michaël Grünewald
# Date: Ven 14 mar 2008 11:00:31 CET
# Lang: fr_FR.ISO8859-1

# $Id$

# Copyright (c) 2006, 2007, 2008, Michaël Grünewald
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

mkheader_process()
{
if ! [ -e $1 ]; then
    echo "File $1 does not exist." 1>&2
    exit 1
fi

header_ctime=`stat -f '%c' $1`
header_cdate=`date -j -f '%s' $header_ctime`
header_lang=${LANG}
header_author=`pw user show $USER | cut -d: -f 8`

ed -s $1 > /dev/null <<EOF
2
2,/^[^#]/g/^# [A-Z][a-zA-Z]*:/d
2,/^[^#]/g/^# \$Id/d
2,/^[^[:blank:]]/g/^\$/d
2i

# Author: $header_author
# Date: $header_cdate
# Lang: $header_lang

# \$Id\$

.
w
q
EOF
}

for file in "$@"; do
    mkheader_process $file
done

### End of file `mkheader.sh'
