# Getting started with a LaTeX document

After reading this document, you will know how to use **BSD Owl
Scripts** to support you in the preparation and maintenance of
**LaTeX** documents and especially:

 - How to produce a PDF file out of your manuscript.
 - How to prepare a document using a bibliography.
 - How to prepare a document featuring METAPOST figures.

This covers only the simplest use cases, the guide
“[Production of LaTeX documents][latex-doc]” gives a deeper exposition
of the features found in **BSD Owl Scripts** and their use.

  [latex-doc]: LaTeXDocument.md


## Produce a PDF file out of our manuscript

We assume that we just created a manuscript `mylastarticle.tex` and
will now prepare our system to let **BSD Owl Scripts** prepare the
final PDF file.

Along with our file `mylastarticle.tex` we create a `Makefile` with
the following contents:

```makefile
DOCS=       mylastarticle.tex
.include "latex.doc.mk"
```

Then we can `make` our document and `make clean` after this.


## Prepare a document using a bibliography

If our document requires a bibliography prepared by **bibtex** we just
need to add `USES+=bibtex` to our `Makefile`:

```makefile
DOCS=       mylastarticle.tex
USES+=      bibtex
.include "latex.doc.mk"
```

This will automatically process our bibliography database with
**bibtex.**  If our bibliography database does not lie in the same
directory as our article, we should tell **BSD Owl Scripts** where
that database is located.  For this, we use the `BIBINPUTS` variable:

```makefile
DOCS=       mylastarticle.tex
USES+=      bibtex
BIBINPUTS=  ${HOME}/share/texmf/bib
.include "latex.doc.mk"
```

Note that `make clean` will not remove the compiled bibliography, so
that we can `clean` your directory before sending it to an editor or
the arXiv.  To get rid of the compiled bibliography, we can use the
more powerful `make realclean` mantra.

**BSD Owl Scripts** can also take care of our **METAPOST** figures. If
we use the `grahicx` package in **LaTeX.** all we need to do is to
enumerate our metapost source files in the `FIGS` variable:

```makefile
DOCS=       mylastarticle.tex
FIGS=       desargues.mp
FIGS+=      conics.mp
.include "latex.doc.mk"
```

The next time we `make` our document, **METAPOST** will be called
automatically. Please note that **BSD Owl Scripts** runs **METAPOST**
with the following options:

```
-s 'prologues=3'
-s 'outputtemplate="%j-%c.mps"'
```

With a similar intent as for bibliographies, making `clean` will not
remove your pictures but making `realclean` will.
