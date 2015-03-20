#!/bin/sh

### mp2png.sh -- Convert METAPOST output to PNG

# Author: Michael Grünewald
# Date: Sat Dec 10 09:58:48 GMT 2005


# Global Variables:

AUTHOR="Michael Grünewald <michipili@gmail.com>"
COPYRIGHT="©2005–2014"
PROGNAME=$(basename "$0")
OUTPUTNAME=''

# resolution [1200]
#  Resolution of PostScript rendering.

resolution=1200


# Ancillary functions

prerr()
{
    echo "$@" 1>&2
}

HELP()
{
    iconv -f utf-8 <<EOF
Usage: $PROGNAME [-h] [-r resolution] [-o output] input
 Convert from METAPOST output to PNG
Options:
 -h Display a cheerful help message to you.
 -o Specify an output name.
 -r RESOLUTION [$resolution]
    Indicate a resolution, in dot per inches. See Notes below.
Notes:
 The conversion is done thanks to GraphicsMagick.
 The program will not work if you use the prologue facility (if you
 do not know about it, this is probably ok).
 Typical resolution for screen viewing ranges from 72 to 100, for
 deskjet printers from 300 to 400, and for laserjet or other high
 quality device, from 600 to above.
Author: Michael Grünewald
Copyright: ${COPYRIGHT}
EOF
}

INVALIDOPT() {
    prerr "${PROGNAME}: unknown option: $1"
}


# mp2png_process INPUTFILE OUTPUTFILE
#  Convert METAPOST output to PNG
mp2png_process()
{
    gm convert -density "$resolution" "$1" "$2"
}

mkoutputname()
{
    if [ -z "$OUTPUTNAME" ]; then
	printf '%s\n' "${1%.mps}.png"
    else
	printf '%s\n' "$OUTPUTNAME"
    fi
}

# Process Arguments

while getopts "ho:r:" OPTION; do
    case $OPTION in
	h) HELP; exit 0;;
	r) resolution="${OPTARG}";;
	o) OUTPUTNAME="${OPTARG}";;
	?) INVALIDOPT $OPTION; HELP; exit 1;;
    esac
done

shift $(expr $OPTIND - 1)

# Let's roll

for a in "$@"; do mp2png_process "$a" $(mkoutputname "$a"); done

### End of file `mp2png.sh'
