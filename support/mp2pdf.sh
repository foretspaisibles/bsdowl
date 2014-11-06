#!/bin/sh

### mp2pdf.sh -- Convert METAPOST output to PDF

# Author: Michael Grünewald
# Date: Sam 10 déc 2005 09:58:48 GMT


# Global Variables:

AUTHOR="Michael Grünewald <michipili@gmail.com>"
COPYRIGHT="©2005–2014"
PROGNAME=`basename "$0"`


# Ancillary functions

prerr()
{
    echo "$@" 1>&2
}

HELP()
{
    cat - <<EOF
Usage: $PROGNAME [-h] [-r resolution] [file1 [file2 [...]]]
 Converts from MetaPost output to PNG
Options:
 -h Display a cheerful help message to you.
Notes:
 The conversion is done thanks to TeX and epsf.tex.
Author: Michael Grünewald
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

### Roll it

mp2pdf_process()
{
    local file
    file=`mktemp mp2pdf.XXXXX`
    cp $1 $file
    mp2eps $file
    epstopdf --outfile=${1%.mps}.pdf $file.eps
    rm $file $file.eps
}

# Process Arguments
while getopts "h" OPTION; do
    case $OPTION in
	h) HELP; exit 0;;
	?) INVALIDOPT $OPTION; HELP; exit 1;;
    esac
done

shift `expr $OPTIND - 1`

for arg in "$@"; do mp2pdf_process "$arg"; done

### End of file `mp2pdf.sh'
