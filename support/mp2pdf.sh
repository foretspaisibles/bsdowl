#!/bin/sh

### mp2pdf.sh -- Converts METAPOST output to PNG

# Author: Michaël Le Barbier Grünewald
# Date: Sam 10 déc 2005 09:58:48 GMT
# Lang: fr_FR.ISO8859-15

# $Id$


# Global Variables:

AUTHOR="Michaël Le Barbier Grünewald <michael.grunewald@laposte.net>"
COPYRIGHT="(c)2005"
PROGNAME=`basename "$0"`

resolution=600

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
 -r RESOLUTION [$resolution]
    Indicate a resolution, in dot per inches. See Notes below.
 -h Display a cheerful help message to you.
Notes:
 The conversion is done thanks to TeX and epsf.tex.
 The program will not work if you use the prologue facility (if you
 do not know about it, this is probably ok).
 Typical resolution for screen viewing ranges from 72 to 100, for
 deskjet printers from 300 to 400, and for laserjet or other high
 quality device, from 600 to above.
Author: Michaël Le Barbier Grünewald
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
    epstopdf --outfile=$1.pdf $file.eps
    rm $file $file.eps
}

# Process Arguments
while getopts "hr:" OPTION; do
    case $OPTION in
	r) resolution=${OPTARG};;
	h) HELP; exit 0;;
	?) INVALIDOPT $OPTION; HELP; exit 1;;
    esac
done

shift $(( $OPTIND - 1 ))

for arg in "$@"; do mp2pdf_process "$arg"; done

### End of file `mp2pdf.sh'
