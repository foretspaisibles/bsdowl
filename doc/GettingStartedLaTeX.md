# Getting started with a LaTeX document

Here is how BSD Owl Scripts can help you to write your new
article.  First of all, create a directory to hold your files and put
your first version of your TeX source there.  We assume for this
example that you called it `mylastarticle.tex`. Along your file,
create a `Makefile` with the following contents:

    DOCS=       mylastarticle.tex
    TEXDEVICE=  pdf
    .include "latex.doc.mk"

Then you can `make` your document and `make clean` it.  The line
setting `TEXDEVICE` tells BSD Owl Scripts that you want to
actually use `pdflatex` but if you are happy with DVI output you can
leave this line aside.  If your document requires a bibliography
prepared by `bibtex` just set `USE_BIBTEX` to `yes` as in

    DOCS=       mylastarticle.tex
    USE_BIBTEX= yes
    TEXDEVICE=  pdf
    .include "latex.doc.mk"

This will automatically process your bibliography database with
`bibtex`.  If your bibliography database does not lie in the same
directory as your article, you should tell BSD Owl Scripts its
location:

    DOCS=       mylastarticle.tex
    USE_BIBTEX= yes
    BIBINPUTS=  ${HOME}/share/texmf/bib
    TEXDEVICE=  pdf
    .include "latex.doc.mk"

Note that `make clean` will not remove the compiled bibliography, so
that you can `clean` your directory before sending it to an editor or
the arXiv.  To get rid of the compiled bibliography, use the more
powerful `make realclean` mantra.

BSD Owl Scripts can also take care of your METAPOST figures,
If you use the `grahicx` package in LaTeX, all you need to do is to
list your metapost source files in the `FIGS` variable:

    DOCS=       mylastarticle.tex
    FIGS=       desargues.mp
    FIGS+=      conics.mp
    TEXDEVICE=  pdf
    .include "latex.doc.mk"

and METAPOST wil be called automatically the next time you `make` your
document.  Please be sure to set

    outputtemplate := "%j-%c.mps";

in your METAPOST sources.  As for bibliographies, making `clean` will
not remove your pictures but making `realclean` will.
