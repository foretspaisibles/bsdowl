#!/bin/sh

### mp2eps.sh -- Convert METAPOST output to PostScript

# Author: Michael Grünewald
# Date: Sat Dec 10 2005 09:58:48 GMT

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


# Global Variables:

AUTHOR='Michael Grünewald <michipili@gmail.com>'
COPYRIGHT='©2005–2014'
PROGNAME=$(basename "$0")

OUTPUTFILE=''


# Ancillary functions

prerr()
{
    1>&2 printf "$@"
}

HELP()
{
    iconv -f utf-8 <<EOF
Usage: $PROGNAME [-h] [-o output] input
 Convert METAPOST output to encapsulated PostScript
Options:
 -h Display a cheerful help message to you.
 -o Specify an output name.
Notes:
 The conversion is done thanks to TeX and epsf.tex.  This tool is
 useful to circumvent a bug in Ghostscript which does not interpret
 correctly bounding boxes.
Author: Michael Grünewald
Copyright: ${COPYRIGHT}
EOF
}

INVALIDOPT() {
    prerr "${PROGNAME}: unknown option: $1"
}


# Working Functions

# mp2eps_process INPUTFILE OUTPUTFILE
#  Convert METAPOST output to EPS
mp2eps_process() {
    local inputfile outputfile basename texbase texfile

    inputfile="$1";
    outputfile="$2"
    basename="${inputfile%.mps}"
    texbase=$(mktemp "${basename}_XXXX")
    texfile="$texbase.tex"

    cat > "$texfile" <<EOF
\nopagenumbers
\input epsf
\setbox0=\vbox{%
  \offinterlineskip
  \hbox to 0pt{\epsfbox{$inputfile}\hss}%
  \offinterlineskip
}%
\shipout\box0\relax
\end
EOF

    tex "$texfile"
    dvips $DVIPS_OPTS -E -j -o "$outputfile" "$texbase"
    rm -f "$texbase"*
}

mkoutputname()
{
    if [ -z "$OUTPUTNAME" ]; then
	printf '%s\n' "${1%.mps}.eps"
    else
	printf '%s\n' "$OUTPUTNAME"
    fi
}


# Process Arguments

DEBUG=no
OUTPUTFILE=''

while getopts "Dho:" OPTION; do
    case $OPTION in
	D)	DEBUG=yes;;
	h)	HELP; exit 0;;
	o)	OUTPUTFILE="$OPTARG";;
	?)	INVALIDOPT $OPTION; HELP; exit 1;;
    esac
done

if [ $DEBUG = no ]; then
    exec 2>/dev/null 1>/dev/null
else
    echo Debugging 1>&2
fi

shift $(expr $OPTIND - 1)

for arg in "$@"; do
    mp2eps_process "$arg" $(mkoutputname "$arg");
done

### End of file `mp2eps.sh'
