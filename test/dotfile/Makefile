### Makefile -- Test misc.dotfile.mk

# Author: Michaël Grünewald
# Date: Sam  7 jul 2007 18:12:22 CEST
# Lang: fr_FR.ISO8859-1

# $Id$


### SYNOPSIS

# $ make -I ../../make -I ../../misc install

DOTFILE+= dot.cshrc
DOTFILE+= dot.emacs

DOTFILEMODE.dot.cshrc = 644

DOTFILEDIR = ${.CURDIR:C%^${HOME}%%:H}/tmp/dotfile
.include "misc.dotfile.mk"

### End of file `Makefile'
