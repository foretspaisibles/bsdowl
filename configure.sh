#!/bin/sh

# Author: Michaël Grünewald
# Date: Dim 13 avr 2008 23:46:52 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

# This simple configure script accepts the `--prefix' and `--destdir'
# options.

DESTDIR="${DESTDIR:-}"
PREFIX="${PREFIX:-/usr/local}"

while [ $# -gt 0 ]; do
    case $1 in
	--prefix=*)	PREFIX="${1#--prefix=}";;
	--destdir=*)	DESTDIR="${1#--destdir=}";;
	*)		echo "Failure" 1>&2; exit 1;;
    esac
    shift
done

cat > Makefile.inc <<EOF
.MAKEFLAGS: -I \${.CURDIR}/Library/Make
USE_SWITCH_CREDENTIALS=yes
DESTDIR=${DESTDIR}
PREFIX=${PREFIX}
CLEANFILES=Makefile.inc
EOF
