#!/bin/sh

### mp2eps.sh -- Converts METAPOST output to PostScript

# Author: Michaël Grünewald
# Date: Sam 10 déc 2005 09:58:48 GMT
# Lang: fr_FR.ISO8859-15

# $Id$


# Global Variables:

AUTHOR="Michaël Grünewald <michael.grunewald@laposte.net>"
COPYRIGHT="(c)2005"
PROGNAME=`basename "$0"`

# Ancillary functions

prerr()
{
    echo "$@" 1>&2
}

HELP()
{
    cat - <<EOF
Usage: $PROGNAME [-h] [file1 [file2 [...]]]
 Converts from MetaPost output to Encapsulated Postscript
Options:
 -h helpme
Notes:
 The conversion is done thanks to TeX and epsf.tex.
 Pour des résultats optimaux, le fichier de sortie de MetaPost ne doit pas
 utiliser la fonctionnalité des prologues.
Author: ${AUTHOR}
Copyright: ${COPYRIGHT}
EOF
}

INVALIDOPT() {
    prerr "${PROGNAME}: unknown option: $1"
}

is_yes ()
{
    case "$1" in
	[Yy][Ee][Ss]) return 0;;
	*) 		return 1;;
	esac
}

is_no ()
{
    case "$1" in
	[Nn][Oo])	return 0;;
	*)		return 1;;
	esac
}

# Working Functions

process_arg() {
    local inputfile="$1";
    local basename=`basename $inputfile .mp`
    local texbase=`mktemp ${basename}_XXXX`
    local texfile=$texbase.tex
    local epsfile=$basename.eps

    cat > $texfile <<EOF
\nopagenumbers
\input epsf
\setbox0=\vbox{%
  \offinterlineskip
  \epsfbox{$inputfile}%
  \offinterlineskip
}%
\shipout\box0\relax
\end
EOF

    tex $texfile 2>&- 1>&-
    dvips $DVIPS_OPTS -E -j -o $epsfile $texbase 2>&- 1>&-
    rm -f $texbase*
}

# Process Arguments
while getopts "h" OPTION; do
    case $OPTION in
	h)	HELP; exit 0;;
	?)	INVALIDOPT $OPTION; HELP; exit 1;;
    esac
done

shift $(( $OPTIND - 1 ))

for arg in "$@"; do process_arg "$arg"; done

### End of file `mp2eps.sh'
