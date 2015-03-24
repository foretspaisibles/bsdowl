# Producing LaTeX documents

On this page, you will learn how to use
BSD Owl Scripts (`bsdowl`) to:

- produce simple documents and publish them on the file system;
- produce the bibliography of your LaTeX document with BIBTeX;
- produce the index of your LaTeX document;
- produce figures for your document with METAPOST;
- deal with documents having parts that need to be automatically generated;
- deal with documents whose source spans across several directories;
- produce standalone figures with METAPOST.


# Foreword: working with TeX or LaTeX

There is multiple TeX formats in use, plain TeX and LaTeX are
examples of such formats.  The LaTeX format enjoys a wide community of
users, so the module `latex.doc.mk` is used in examples. However most of
the following applies to the module `tex.doc.mk` as
well. Some paragraphs in the sequel document mechanisms specific to
`latex.doc.mk`, they are explicitly identified as such.


# Simple use

The preparation of a simple document with LaTeX itself is very
easy, thus the use of `bsdowl` may at a first glance look like a useless
complication instead of a simplification. It provides some
useful features, however.


## The first time

Assume the file `script.tex` holds your
manuscript. Put it in a directory dedicated to your document, and
create a `Makefile` file (note the leading capital) with the following
content:

```makefile
DOCUMENT=		script.tex
.include "latex.doc.mk"
```

Your document's directory now contains the `paper.tex` file and the
`Makefile` described above.  Point your shell's working directory to
your document's directory, and issue the `make` command:

```console
% make
make build
===> Multipass job for script.pdf (aux)
latex script.tex
This is pdfeTeX, Version 3.141592-1.21a-2.2 (Web2C 7.5.4)
entering extended mode
(./script.tex
LaTeX2e <2003/12/01>
...
```

If your manuscript has no error, you end up with the following
_object files_ in your working directory:

```console
% ls
Makefile    script.log
script.aux  script.tex
script.pdf  script.toc
```

Once you are done with the objects, you can clean the directory
with the `make clean` mantra:

```console
% make clean
rm -f script.pdf script.log script.aux script.toc
```

Cleaning the directory is an optional step, but it prevents your
storage and your archive media to end up filled with unused data, that
can be quickly recreated on demand. While DVI files are usually very
small, a few hundred kilobytes, the PS or PDF objects are often much
larger.


## Install or publish documents

Before you clean up your working directory with the _make clean_
mantra, you may wish to store the document you created in some
adequate place of the local file system.  This step is called
_installation_ of your document, because it is analogous to the
installation of a program you freshly compiled.  You require the
installation of your document with the `make install` command, but you
must first tell make which place is actually adequate. This is done by
assigning the _DOCDIR_ variable with the path to the directory
you want your files to be copied to, as displayed by the following
`Makefile`:

```makefile
DOCUMENT=		script.tex

DOCDIR=			${HOME}/doc/report
.include "latex.doc.mk"
```

You can then proceed with the `make install` command:

```console
% make install
install -d /home/michi/doc/report
install -o michi -g michi -m 440 script.pdf /home/michi/doc/report
```

In comparison with the manual approach for storing the object in a
safe place with the _cp_ command, you save retyping the target
directory name the next time you update your document.  But delegating
this easy step to the `Makefile` has other benefits:

- It eases the organisation of your document sources library.
- It scales to a large number of documents, see _Working with a large
  number of documents_ below.
- In draft-mode, a time stamp identifying the compilation time is
  automatically added to the file name, see below.


## Select an output format

The TeX tool chain is capable of producing electronic documents in
several formats. Commonly used formats are DVI, PostScript (PS) and
PDF. The _TEXDEVICE_ variable governs the format of documents produced
with the help of latex.doc.mk. Its value is usually _pdf_, so
that `latex.doc.mk` will produce a PDF file from your source.  Other
possible values are _ps_ or _dvi_.  If you configured a
PostScript printer _TEXPRINTER_ with the texconfig program, you
also can use _TEXPRINTER.ps_ as a value in _TEXDEVICE,_ it will
instruct `dvips` to use the settings for _TEXPRINTER_ when translating
your DVI file to PostScript. It is also possible to list several
output formats in _TEXDEVICE,_ like _dvi pdf ps.TEXPRINTER1 ps.TEXPRINTER2_.


## Drafts and multipass jobs

Some formats or macros need your manuscript to be processed several
times by TeX or LaTeX before you obtain the final version of your
document.  The `latex.tex.mk` module enforces multipass treatment of
your manuscript, because LaTeX needs this to produce correct cross
references created with _label_ and _ref_ commands within your
document.  The `doc.tex.mk` module will not do multiple treatment of
your manuscript unless you set the variable _MULTIPASS_ to a list of
names, each element giving its name to a pass.  The choice of these
names does not have a real importance, as they are only displayed to
the user.  It is even possible to specify the same name several times.

In the early stages of existence of a document, updates are likely to
be frequent and it is thus desirable to avoid the lengthy multiple
passes processing.  `bsdowl` has a draft mode for this. To enable the draft
mode, add a statement `USES+= draft` to your `Makefile`,
as shown by the following example:

```makefile
DOCUMENT=		script.tex
USES+=			draft
.include "latex.doc.mk"
```

When you have finished polishing your manuscript, you can remove the
`USES+= draft` assignment from the `Makefile`, your paper is then ready for a
last _make_ run producing the final version of your document.  If you
are satisfied with it, you can _install_ it.

When working on a document, it might be useful to keep copies of the
objects you produced at some point of your work.  For instance,
picture yourself sending a copy of your work to a friend.  Your friend
will read your paper with attention and send you back his comments,
but in the meanwhile, you kept on improving your document.  When you
receive the comments of your friend, you will compare them to the
document you sent him.  It is therefore useful to keep a copy of it.
The best way to do this is probably to use a
[RCS](http://en.wikipedia.org/wiki/Revision_Control_System), a
software keeping track of the various revisions of a file. If you do
not use such a system and want to try one, you might be interested in
GIT, especially if you are relying on EMails to organise your
collaborative work.

When working with the `USES+= draft` setting, the name of installed
documents is modified to display the time when `make install` was run.
This should help to identify the produced version.  If you use a GIT
or Subversion, you should modify the `USES+= draft` statement to
`USES+= draft:git` or `USES+= draft:svn`.  If you do so, the time of
the last commit and its identifier (the short hash for git and the
revision number for svn) is used to identify the produced version.
This is much more useful than the time at which `make install` was run
since it unambiguously identifies a state of your repository.


## Split document

If you are working on a complex document, you certainly have split
your sources into several files. Usually one file per chapter, or per
section, plus a main file containing the preamble and many
_input_ statements to instruct LaTeX to read all of the files
representing the document's contents.

Assume that your document is split into a main file `galley.tex`
and two other files `part1.tex` and `part2.tex`. Your `galley.tex`
certainly looks like this:

```latex
\documentclass{article}
\begin{document}
\input{part1}
\input{part2}
\end{document}
```

A suitable `Makefile` is then:

```makefile
DOCUMENT=		galley.tex
SRCS=			part1.tex
SRCS+=			part2.tex
.include "latex.doc.mk"
```

# More advanced features

## Figures with METAPOST

Modules `latex.doc.mk` and `tex.doc.mk` comes with a nice support for
[METAPOST](http://cm.bell-labs.com/who/hobby/MetaPost.html).
This is something worth noting, since METAPOST is
often the right tool to be used for drawing figures appearing in TeX
documents, but support for it is missing in many GUI editors for
LaTeX.

These modules assume that METAPOST source does not manipulate the
values of the variables `prologues`, `outputtemplate` and
`outputformat`.  They set-up these variables so that:

```metapost
prologues := 3;
outputtemplate := "%j-%c.mps";
```

The first declaration parametrises the inclusion of fonts in the
output, while the second reconfigures the names used for output.

Assume you prepared illustrations for your article with METAPOST,
and split your illustrations into two files `illustr1.mp` and
`illustr2.mp`. To let `latex.doc.mk` handle the production of your
figures, add _SRCS_ statements to your `Makefile`:

```makefile
DOCUMENT=		galley.tex
SRCS=			part1.tex
SRCS+=			part2.tex
SRCS+=			illustr1.mp
SRCS+=			illustr2.mp
.include "latex.doc.mk"
```

Then type in _make_ at the shell prompt. The `latex.doc.mk` will
then figure out how many illustrations are present in each file, and
produce the image files required by your _TEXDEVICE._  For instance, if
your _TEXDEVICE_ is _pdf,_ and `illustr1.mp` contains two figures
introduced by `beginfig(1)` and `beginfig(2)`, you end up with four files

```console
% ls *.mps
illustr1-1.mps
illustr1-1.pdf
illustr1-2.mps
illustr1-2.pdf
```

The first files ending in `.mps` are intermediary files in PostScript format,
and the remaining ones are PDF files suited for inclusion
in your document.

Using the _graphicx_ package, inclusion is as easy as it should be:

```latex
\includegraphics{illustr1-1}%
```

_Discovering METAPOST._
It seems that many people do not know about METAPOST.  If it is true
for you but are interested in discovering it, the first good news is
that this program is included by many (if not all) TeX distributions,
hence it is probably already available on your system.

The second good news is that you can easily find plenty of information
and examples of its use on the WWW. For instance, the
[TeX users group](http://www.tug.org/metapost.html)
has a page on its website devoted to this tool. The list you will find
there is pretty long, so let me add that I especially like the
[introduction written by André Heck](http://staff.science.uva.nl/~heck/Courses/mptut.pdf), it might also be a good starting point for you.


## Standalone METAPOST documents

The module `mpost.doc.mk` allows the creation of METAPOST pictures in
the following formats: Encapuslated PostScript, PDF, PNG and SVG.
Assume that you prepared two series of illustrations in files
`illustr1.mp` and `illustr2.mp` and want to produce them in each of
the aforementioned formats.  RThe corresponding `Makefile` is:

```makefile
DOCUMENT=		illustr1.mp
DOCUMENT+=		illustr2.mp
MPDEVICE=		eps pdf png svg
.include "mpost.doc.mk"
```


## Bibliography

`bsdowl` supports the preparation of bibliographies with BibTeX. First,
you must be sure that the program TeX will find the bibliographic
databases you enumerated in your document with _bibliography_
statements.  It is customary to gather bibliographic databases in some
directory, for instance _${HOME}/share/bib_.  To let bibtex
find these files, it is enough to add _${HOME}/share/bib_ to the content
of the variable _BIBINPUTS_.  If your bibliographic databases are
scattered among several directories, you just need to let each of them
appear in the value of the variable _BIBINPUTS_:

```makefile
DOCUMENT=		galley.tex
SRCS=			part1.tex
SRCS+=			part2.tex
BIBINPUTS=		${HOME}/share/bib
BIBINPUTS+=		${.CURDIR}/morebib
USES+=			bibtex
.include "latex.doc.mk"
```

Note that the _make clean_ mantra will leave intact the BBL file
produced by bibtex.  This is because you sometimes need to send this
file to your publisher rather than an unprocessed bibtex database.
Hence the _make clean_ or _make distclean_ will leave you document's
directory in the state you want to have it when you want to
redistribute it. To get rid of the BBL file as well, you need to use
the more powerful mantra _make realclean_.


## Index

If an index must be prepared for a LaTeX document with the program
`makeindex` a `USES+=index` statement must be added to the `Makefile`,
as displayed by the following example:

```makefile
DOCUMENT=		galley.tex
SRCS=			part1.tex
SRCS+=			part2.tex
USES+=			index
.include "latex.doc.mk"
```


## Several documents in the same directory

While it is often a good idea to reserve a directory for each of
your documents, you might have some reasons to keep several documents
in the same directory.  You have your reasons and they are probably
good ones, so `bsdowl` will do its best to help you.

We assume that you have two documents whose sources are living in the
same directory, let's say an article and an abridged version of this
article. These files share a macro file `macro.tex`, but are otherwise
rather independent from LaTeX's point of view. The text of the article
is split across two files, `section1.tex` and `section2.tex`. The
summary has just one text file `summary.tex`. The Makefile used looks
like this:

```makefile
DOCUMENT=		article.tex
DOCUMENT+=		summary.tex

SRCS=			macros.tex

SRCS.article.tex=	section1.tex
SRCS.article.tex+=	section2.tex

.include "latex.doc.mk"
```


## Automatically generating a part of a document

Assume you are working on a document containing a table whose
content is likely to change several times and will need to be
updated.  Such a table could be a budget:  when information on the
situation evolves, so does the budget.  It can be quite tedious to
type in a table in LaTeX, and updating it might even be trickier.  In
such a situation, it is probably a good idea to write a program
reading the raw data of your table and writing a LaTeX table
displaying your data and everything you want to compute from it.  Such
a program is usually very easy to write, because you only need to deal
with text files all of the time.

So you have gathered the raw data of your table in the file
`table.raw` and written a small program gentable that will write for you
a LaTeX table on its standard output.  In your manuscript, you use the
name _table_ to refer to the file containing the generated
table. Here is your Makefile:

```makefile
DOCUMENT=		galley.tex

table.tex: gentable table.raw
	./gentable < table.raw > table.tex

REALCLEANFILES+=	table.tex

.include "latex.doc.mk"
```

The example assume that the _gentable_ utility in the
recipe above is a filter, hence input and output are defined with the
help of shell redirections.  Other utilities may have other ways to
define their input and output, a described by their respective manuals.

If you send your files to someone else, he will maybe not want to
run your program gentable, so it is better to list `table.tex` in
_REALCLEANFILES_ than in _CLEANFILES_: you can clean your directory
with `make clean` archive its contents and send the archive to someone
else without handling the generated `table.tex` in a special way.

Of course, you can compute some text or a METAPOST picture, or
pretty-print a piece of code, or whatever, instead of generating a
table!

Note that if you take advantage of the [OBJDIR](Objdir) feature of
`bsdowl`, the production rule for `table.tex` should actually be:

```makefile
table.tex: gentable table.raw
	${.CURDIR}/gentable < ${.ALLSRC:M*.raw} > ${.TARGET}
.include "latex.doc.mk"
```

The special variables `.CURDIR`, `.ALLSRC` and `.TARGET` are aware of
the mechansisms involved in the use of [OBJDIR](Objdir).


## Source files spanning across several directories

Some workflows may prescribe that your source files are not located
in a single directory, but disseminated across the file system.

A reason for doing this is that your organisation uses a custom
document class for its letters, where some picture appears.  You do
not want to copy the picture file in each of the folders hosting your
letters, nor do you want to have a symbolic link to the picture in
each of your directories because the file is irrelevant to your work:
you just want to not even know anything about it. The solution to this
problem is to rely on the _TEXINPUTS_ variable, its content is a list
of directories searched by TeX for its input files.

Another reason motivating the dissmenination of source files in
several directories is the preparation of a large document such as a
book.  If the files for each chapter are in separated directories, it
is easy to process an isolated chapter with LaTeX during the
preparation of the manuscript.  TeX must find all these files when it
processes the main file including all the chapters, which is achieved
by setting _TEXINPUTS_ to an appropriate value, as explained in the
sequel.

You can set the _TEXINPUTS_ variable in your environment or in your
`Makefile`, or even write a custom `Makefile` template including this
setting.  The role of this variable for TeX is pretty similar
to the role of the _PATH_ environment variable in your shell.

Assume that the picture visually impersonating your organisation
is in the _${HOME}/share/texmf/tex/organisation/visual.eps_, in
order to let TeX look for files in the folder containing the picture,
you write a _TEXINPUTS_ statement in your _Makefile_, like this:

```makefile
DOCUMENT=		galley.tex
TEXINPUTS=		${HOME}/share/texmf/organisation
.include "latex.doc.mk"
```

If you run _make_ in the folder containing this `Makefile`, you
will see something like this in your terminal:

```console
% make
make build
===> Multipass job for galley.pdf (aux)
env TEXINPUTS=".:${HOME}/share/texmf/organization:" pdflatex galley.tex
This is pdfeTeX, Version 3.141592-1.21a-2.2 (Web2C 7.5.4)
...
```

Take a look at the _TEXINPUTS_ assignment in the _env_
command.  Its difference with respect to the declaration in the
`Makefile` above means that TeX will also look for files
in the current directory (this is what the initial dot stands for) and
all standard TeX locations (this is what the final colon stands for).

If you want to have absolute control on the value of _TEXINPUTS_, you
must add an assignment _USES+=texinputs:strict_ in your
`Makefile`.  If it sees this statement, `bsdowl` will refrain from adding the
initial dot and the final colon to your `TEXINPUTS` declaration.

The supporting macros for METAPOST also understand _TEXINPUTS_ and
_USES+=texinputs:strict_.  There is an analogous variable _MPINPUTS_
governing the look up of METAPOST input files, it is accompanied with an
_USES+=mpinputs:strict_ option.  If you want to have your TeX program and
your METAPOST program to be run with different values for _TEXINPUTS_,
you can pass the correct value to METAPOST through the _MPTEXINPUTS_
variable, this variable is also accompanied by an
_USES+=mptexinputs:strict_ option.


## Working with a large number of documents

We demonstrate how to use the `bps.subdir.mk` module to organise a
collection of documents.  For the purpose of the example, we assume
that you are preparing an electronic journal and want to distribute
each article of the journal as a separate electronic document.  We use
the following simple organisation:

1. We prepare a directory holding each issue of our journal, for
   instance `~/journal`.

2. Each issue of the journal is represented by a subdirectory.

3. Each article of the journal is represented by a subdirectory of the
   directory corresponding to the issue it belongs to.

Assume we already have several articles, as demonstrated by the
following commnad output:

```console
% find ./journal -type f
./journal/issue-2013-1/01-galdal/Makefile
./journal/issue-2013-1/01-galdal/article.tex
./journal/issue-2013-1/02-arathlor/Makefile
./journal/issue-2013-1/02-arathlor/article.tex
./journal/issue-2013-2/01-mirmilothor/Makefile
./journal/issue-2013-2/01-mirmilothor/article.tex
./journal/issue-2013-2/02-eoron/Makefile
./journal/issue-2013-2/02-eoron/article.tex
./journal/issue-2013-2/03-echalad/Makefile
./journal/issue-2013-2/03-echalad/article.tex
```

Names like `galdal`, `arathlor` are the names of fictional authors of
articles of our journal. Each submission has a directory containing
the text `article.tex` of the article and a `Makefile` similar to
those described on this page which can be used to build the matching
article.

Each of these `Makefile`s can actually be as simple as

```Makefile
DOCUMENT=		article.tex
.include "latex.doc.mk"
```

To orchestrate the preparation of all our articles with `bsdowl` we
just need to write additional `Makefile`s:
`
```
./journal/Makefile
./journal/issue-2013-1/Makefile
./journal/issue-2013-2/Makefile
./journal/issue-2013-3/Makefile
```

Each `Makefile` basically contains the list of subdirectories where
_make_ should descend to actually `build`, `install` or `clean`. So
the file `./journal/Makefile` should contain:

```makefile
PACKAGE=		journal

SUBDIR=			issue-2013-1
SUBDIR+=		issue-2013-2
SUBDIR+=		issue-2013-3
.include "bps.subdir.mk"
```

The file `./journal/issue-2013-1/Makefile` should contain:

```makefile
SUBDIR=			01-galdal
SUBDIR+=		02-arathlor
.include "bps.subdir.mk"
```

The remaining files `./journal/issue-2013-2/Makefile` and
`./journal/issue-2013-3/Makefile` can be similarly prepared. With
these settings, the targets `all`, `build`, `clean`, `distclean`,
`realclean` and `install` are delegated to `Makefile`s found in the
subdirectories listed by _SUBDIR_.

The variable `SUBDIR_PREFIX` can be used to define a customised
installation path for each article, so that the `Makefile` building a
document could be

```Makefile
DOCUMENT=		article.tex
DOCDIR=			${HOME}/publish/journal${SUBDIR_PREFIX}
.include "latex.doc.mk"
```

With this setting, the document
`./journal/issue-2013-1/01-galdal/article.pdf` will be installed as
`${HOME}/publish/journal/issue-2013-1/01-galdal/article.pdf` and so
on.  It is possible to tweak this in all possible ways to use
arbitrary naming schemes for installed articles.
