#!@PERL@

### showconfig.pl -- A short program displaying its configuration

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2015 Michael Grünewald
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

my $PACKAGE='@PACKAGE@';

sub ac_config_init
{
    if ($ENV{$_[0]}) {
        return $ENV{$_[0]};
    } else {
        return $_[1];
    }
}


# prefix
#  Installation prefix for machine independant files

my $prefix = ac_config_init('prefix', '@prefix@');


# exec_prefix
#  Installation prefix for machine dependant data

my $exec_prefix = ac_config_init('exec_prefix', '@exec_prefix@');


# bindir
#  Destination of executable programs that users can run

my $bindir = ac_config_init('bindir', '@bindir@');


# sbindir
#  Destination of executable programs that admins can run

my $sbindir = ac_config_init('sbindir', '@sbindir@');


# libexecdir
#  Destination for programs to be run by other programs

my $libexecdir = ac_config_init('libexecdir', "@libexecdir@/${PACKAGE}");


# datarootdir
#  Subsystem where machine-independant files are stored
#
# This variable is useful to define mandir, etc. but not on its own.

my $datarootdir = ac_config_init('datarootdir', '@datarootdir@');


# datadir
#  Destination of idiosyncratic read-only architecture-independent data files

my $datadir = ac_config_init('datadir', "@datarootdir@/${PACKAGE}");


# sysconfdir
#  Destination of read-only data files that pertain to a single machine
#
# To put it another way, this is where host-specific configuration
#  should go.

my $sysconfidr = ac_config_init('sysconfidr', '@sysconfdir@');


# sharedstatedir
#  Destination of host-independent files holding program state

my $sharedstatedir = ac_config_init('sharedstatedir', "@sharedstatedir@/${PACKAGE}");


# localstatedir
#  Destination of host-specific files holding program state

my $localstatedir = ac_config_init('localstatedir', "@localstatedir@/${PACKAGE}");


# runstatedir
#  Destination of host-specific files holding volatile program state

my $runstatedir = ac_config_init('runstatedir', "@runstatedir@/${PACKAGE}");


# docdir
#  Destination of documentation files
#
# This is not for info files, that are stored somewhere else.

my $docdir = ac_config_init('docdir', '@docdir@');


# infodir
#  Destination of info files

my $infodir = ac_config_init('infodir', '@infodir@');


# libdir
#  Destination of object files and libraries of object code

my $libdir = ac_config_init('libdir', '@libdir@');


# localedir
#  Destination of locale-specific message catalogs

my $localedir = ac_config_init('localedir', '@localedir@');


print <<"EOF";
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

### End of file `showconfig.pl'
