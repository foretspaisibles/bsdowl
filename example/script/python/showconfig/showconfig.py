#!@PYTHON@
# coding=utf8

### showconfig.py -- A short program displaying its configuration

# Author: Michael Grünewald
# Date: Sat Nov 22 09:13:30 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

# We implement symbolic directory names following the GNU coding
# standards.  Most of the comments are citations from the GNU coding
# standards:
#
#   The GNU coding standards, last updated September 13, 2013.
#   http://www.gnu.org/prep/standards/html_node/index.html


### IMPLEMENTATION

import os;

def makeval(var, val):
    a = os.getenv(var)
    if not a:
        a = val
    return a

PACKAGE=makeval("PACKAGE", "@PACKAGE@")


# prefix
#  Installation prefix for machine independant files
prefix=makeval("prefix", "@prefix@")


# exec_prefix
#  Installation prefix for machine dependant data
exec_prefix=makeval("exec_prefix", "@exec_prefix@")


# bindir
#  Destination of executable programs that users can run
bindir=makeval("bindir", "@bindir@")


# sbindir
#  Destination of executable programs that admins can run
sbindir=makeval("sbindir", "@sbindir@")


# libexecdir
#  Destination for programs to be run by other programs
libexecdir=makeval("libexecdir", "@libexecdir@")


# datarootdir
#  Subsystem where machine-independant files are stored
#
# This variable is useful to define mandir, etc. but not on its own.
datarootdir=makeval("datarootdir", "@datarootdir@")


# datadir
#  Destination of idiosyncratic read-only architecture-independent data files
datadir=makeval("datadir", "@datadir@")


# sysconfdir
#  Destination of read-only data files that pertain to a single machine
#
# To put it another way, this is where host-specific configuration
#  should go.
sysconfidr=makeval("sysconfidr", "@sysconfidr@")


# sharedstatedir
#  Destination of host-independent files holding program state
sharedstatedir=makeval("sharedstatedir", "@sharedstatedir@")


# localstatedir
#  Destination of host-specific files holding program state
localstatedir=makeval("localstatedir", "@localstatedir@")


# runstatedir
#  Destination of host-specific files holding volatile program state
runstatedir=makeval("runstatedir", "@runstatedir@")


# docdir
#  Destination of documentation files
#
# This is not for info files, that are stored somewhere else.
docdir=makeval("docdir", "@docdir@")


# infodir
#  Destination of info files
infodir=makeval("infodir", "@infodir@")


# libdir
#  Destination of object files and libraries of object code
libdir=makeval("libdir", "@libdir@")


# localedir
#  Destination of locale-specific message catalogs
localedir=makeval("localedir", "@localedir@")

print '''\
PACKAGE=%(PACKAGE)s
prefix=%(prefix)s
exec_prefix=%(exec_prefix)s
bindir=%(bindir)s
sbindir=%(sbindir)s
libexecdir=%(libexecdir)s
datarootdir=%(datarootdir)s
datadir=%(datadir)s
sysconfidr=%(sysconfidr)s
sharedstatedir=%(sharedstatedir)s
localstatedir=%(localstatedir)s
runstatedir=%(runstatedir)s
docdir=%(docdir)s
infodir=%(infodir)s
libdir=%(libdir)s
localedir=%(localedir)s
''' % locals()

### End of file `showconfig.py'
