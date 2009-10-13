### Makefile

# Author: Michaël Le Barbier Grünewald
# Date: Sam  7 jul 2007 18:12:07 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

FILES = texmf.init.mk

FILES+= tex.init.mk
FILES+= tex.doc.main.mk
FILES+= tex.doc.mk
FILES+= tex.device.dvi.mk
FILES+= tex.device.ps.mk
FILES+= tex.device.pdf.mk
FILES+= tex.driver.dvi.mk
FILES+= tex.driver.pdftex.mk
FILES+= tex.driver.dvips.mk
FILES+= tex.mpost.mk
FILES+= tex.files.mk
FILES+= tex.files.main.mk

FILES+= latex.doc.mk
FILES+= latex.bibtex.mk

tex.driver.pdftex.mk: tex.driver.dvi.mk
	sed \
	  -e 's/tex\.driver\.dvi\.mk/tex\.driver\.pdftex\.mk/g'\
	  -e 's/DVI/PDF/g' \
	  -e 's/dvi/pdf/g' \
	  ${.ALLSRC} > ${.TARGET}

tex.device.pdf.mk: tex.device.dvi.mk
	sed -e 's/DVI/PDF/g' -e 's/dvi/pdf/g' ${.ALLSRC} > ${.TARGET}

CLEANFILES+= tex.driver.pdftex.mk
CLEANFILES+= tex.device.pdf.mk

.include "project.mk"

### End of file `Makefile'
