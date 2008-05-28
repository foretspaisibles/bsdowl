### Makefile

# Author: Michaël Grünewald
# Date: Ven 10 fév 2006 16:50:40 GMT
# Lang: fr_FR.ISO8859-1

# $Id$

PROJECT = bsdmakepscripts
VERSION = 1.1
AUTHOR = Michaël Grünewald

SUBDIR+= bps
SUBDIR+= ocaml
SUBDIR+= text
SUBDIR+= misc
SUBDIR+= www
SUBDIR+= support

# Le fichier Makefile.inc est produit par la commande
# `./configure'. Tant que la commande `./configure' n'a pas été
# utilisée pour préparer l'arbre des sources, ce Makefile ne peut pas
# être utilisé.

.include "Makefile.inc"
.include "pallas.mk"

### End of file `Makefile'
