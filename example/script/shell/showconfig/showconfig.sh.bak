#!/bin/sh

### showconfig.sh -- A short program displaying its configuration

# Author: Michael Grünewald
# Date: Fri Nov 21 21:03:03 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

# We implement symbolic directory names following the GNU coding
# standards.  Most of the comments are citations from the GNU coding
# standards:
#
#   The GNU coding standards, last updated September 13, 2013.
#   http://www.gnu.org/prep/standards/html_node/index.html


### IMPLEMENTATION

# These first two variables set the root for the installation. All the
# other installation directories should be subdirectories of one of
# these two, and nothing should be directly installed into these two
# directories.

PACKAGE='@PACKAGE@'


# prefix
#  Installation prefix for machine independant files
: ${prefix:=@prefix@}


# exec_prefix
#  Installation prefix for machine dependant data
: ${exec_prefix:=@exec_prefix@}


# bindir
#  Destination of executable programs that users can run
: ${bindir:=@bindir@}


# sbindir
#  Destination of executable programs that admins can run
: ${sbindir:=@sbindir@}


# libexecdir
#  Destination for programs to be run by other programs
: ${libexecdir:=@libexecdir@/${PACKAGE}}


# datarootdir
#  Subsystem where machine-independant files are stored
#
# This variable is useful to define mandir, etc. but not on its own.
: ${datarootdir:=@datarootdir@}


# datadir
#  Destination of idiosyncratic read-only architecture-independent data files
: ${datadir:=@datarootdir@/${PACKAGE}}


# sysconfdir
#  Destination of read-only data files that pertain to a single machine
#
# To put it another way, this is where host-specific configuration
#  should go.
: ${sysconfidr:=@sysconfdir@}


# sharedstatedir
#  Destination of host-independent files holding program state
: ${sharedstatedir:=@sharedstatedir@/${PACKAGE}}


# localstatedir
#  Destination of host-specific files holding program state
: ${localstatedir:=@localstatedir@/${PACKAGE}}


# runstatedir
#  Destination of host-specific files holding volatile program state
: ${runstatedir:=@runstatedir@/${PACKAGE}}


# docdir
#  Destination of documentation files
#
# This is not for info files, that are stored somewhere else.
: ${docdir:=@docdir@}


# infodir
#  Destination of info files
: ${infodir:=@infodir@}


# libdir
#  Destination of object files and libraries of object code
: ${libdir:=@libdir@}


# localedir
#  Destination of locale-specific message catalogs
: ${localedir:=@localedir@}

cat <<EOF
PACKAGE=${PACKAGE}
prefix=${prefix}
exec_prefix=${exec_prefix}
bindir=${bindir}
sbindir=${sbindir}
libexecdir=${libexecdir}
datarootdir=${datarootdir}
datadir=${datadir}
sysconfidr=${sysconfidr}
sharedstatedir=${sharedstatedir}
localstatedir=${localstatedir}
runstatedir=${runstatedir}
docdir=${docdir}
infodir=${infodir}
libdir=${libdir}
localedir=${localedir}
EOF

### End of file `showconfig.sh'
