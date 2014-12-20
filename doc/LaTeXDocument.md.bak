# Producing LaTeX documents

On this page, you will learn how to use **BSD Owl Scripts** to:

 - Produce simple LaTeX documents and publish them on the file system.
 - Install or publish LaTeX documents.
 - Produce LaTeX documents in various output formats.
 - Produce *drafts* of LaTeX documents.
 - Produce documents having more than one source file.
 - Produce documents including METAPOST figures.
 - Produce standalone figures with METAPOST.
 - Produce documents including BibTeX bibliographies
 - Produce an index for a LaTeX document.
 - Produce documents having parts that need to be automatically
   generated, like tables or database reports.
 - Deal with documents whose source spans across several directories.
 - Deal with a huge number of documents.

There is a useful program called **latexmk** whose functionality
partially overlaps what **BSD Owl Scripts** offers.  These tools are
however built under distinct, complementary perpsectives.  Indeed
**latexmk** focuses on the very production of a document, while
**BSD Owl Scripts** allows to integrate the production of this document
in the context of the production of a full project.  The integration of
**latexmk** in **BSD Owl Scripts** is planned.


## Foreword — Working with TeX or LaTeX

There is multiple TeX formats in use, *plain TeX* and *LaTeX* are
examples of such formats.  The LaTeX format enjoys a wide community of
users, so the module `latex.doc.mk` is used in examples. However most
of the following also applies to the module `tex.doc.mk` supporting
*plain TeX*.  It is easy to write a customised version of
`latex.doc.mk` to support other TeX formats, if required.
Some paragraphs in the sequel document mechanisms specific to
`latex.doc.mk`, they are explicitly identified as such.


## Produce simple LaTeX documents

Assume the file `script.tex` holds our
manuscript. We put it in a directory dedicated to our document, and
create a `Makefile` file (note the leading capital) with the following
content:

```makefile
DOCUMENT=		script.tex
.include "latex.doc.mk"
```

Our document's directory now contains the `paper.tex` file and the
`Makefile` described above.  We visit this directory with our shell
and issue the `make` command:

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

If our manuscript has no error, we end up with the following
_object files_ in our working directory:

```console
% ls
Makefile    script.log
script.aux  script.tex
script.pdf  script.toc
```

Once we are done with these objects, we can clean the directory
with the `make clean` mantra:

```console
% make clean
rm -f script.pdf script.log script.aux script.toc
```

Cleaning the directory is an optional step, but it prevents our
storage and your archive media to end up filled with unused data, that
can be quickly recreated on demand.  While DVI files are usually very
small, a few hundred kilobytes, the PS or PDF objects are often much
larger.


## Install or publish documents

Before we clean up your working directory with the `make clean`
mantra, we may wish to store the document we created in some
adequate place of the local file system.  This step is called
_installation_ of our document, because it is analogous to the
installation of a program we freshly compiled.  We can require the
installation of our document with the `make install` command, but we
must first tell make which place is actually adequate. This is done by
assigning the _DOCDIR_ variable with the path to the directory
we want our files to be copied to, as displayed by the following
`Makefile`:

```makefile
DOCUMENT=		script.tex
DOCDIR=			${HOME}/doc/report
.include "latex.doc.mk"
```

We can then proceed with the `make install` command:

```console
% make install
install -d /home/michi/doc/report
install -o michi -g michi -m 440 script.pdf /home/michi/doc/report
```

In comparison with the manual approach for storing the object in a
safe place with the _cp_ command, we save retyping the target
directory name the next time we update our document.  But delegating
this easy step to the `Makefile` has other benefits:

- It eases the organisation of our document sources library.
- It scales to a large number of documents, see _Working with a large
  number of documents_ below.
- In draft-mode, a time stamp identifying the compilation time or the
  last modification time is automatically added to the file name, see
  below.


## Produce LaTeX documents in various output formats

The TeX tool chain is capable of producing electronic documents in
several formats. Commonly used formats are DVI, PostScript (PS) and
PDF.  The _TEXDEVICE_ variable governs the format of documents produced
with the help of latex.doc.mk.  Its value is usually _pdf_, so
that `latex.doc.mk` will produce a PDF file from our source.  Other
possible values are _ps_ or _dvi_.  If we configured a
PostScript printer _TEXPRINTER_ with the **texconfig** program, we
also can use _TEXPRINTER.ps_ as a value in _TEXDEVICE,_ it will
instruct `dvips` to use the settings for _TEXPRINTER_ when translating
our DVI file to PostScript. It is also possible to list several
output formats in _TEXDEVICE,_ like _dvi pdf ps.TEXPRINTER1 ps.TEXPRINTER2_.


### Produce drafts of LaTeX documents

Some formats or macros need our manuscript to be processed several
times by TeX or LaTeX before we obtain the final version of our
document.  The `latex.tex.mk` module enforces multipass treatment of
the manuscript, because LaTeX needs this to produce correct cross
references created with _label_ and _ref_ commands within our
document.  The `doc.tex.mk` module will not do multiple treatment of
our manuscript unless we set the variable _MULTIPASS_ to a list of
names, each element giving its name to a pass.  The choice of these
names does not have a real importance, as they are only displayed to
the user.

In the early stages of existence of a document, updates are likely to
be frequent and it is thus desirable to avoid the lengthy multiple
passes processing.  **BSD Owl Scripts** has a draft mode for this.
To enable the draft mode, we add a statement `USES+= draft` to
our `Makefile`, as shown by the following example:

```makefile
DOCUMENT=		script.tex
USES+=			draft
.include "latex.doc.mk"
```

When we have finished polishing your manuscript, we can remove the
`USES+= draft` assignment from the `Makefile`, our paper is then ready for a
last _make_ run producing the final version of our document.  If we
are satisfied with it, we can _install_ it.

When working on a document, it might be useful to keep copies of the
objects we produced at some special point of your work.  For instance,
picture ourselves sending a copy of our work to a friend.  Our friend
will read our paper with attention and send us back his comments,
but in the meanwhile, we kept on improving our document.  When we
receive the comments of our friend, we will compare them to the
document we sent him.  It is therefore useful to keep a copy of it.
The best way to do this is to use a [RCS][wikipedia-rcs],
a special software keeping track of the various revisions of a file.
Those who do not use such a system and want to try one might be
interested in **git**, especially if they are relying on EMails to
organise your collaborative work.

When working with the `USES+= draft` setting, the name of installed
documents is modified to display the time when `make install` was run.
This should help to identify the produced version.  If we use a **git**
or **subversion** to keep track of the revision of our files,
we should modify the `USES+= draft` statement to
`USES+= draft:git` or `USES+= draft:svn`.  If we do so, the time of
the last commit and its identifier (the short hash for **git** and the
revision number for **subversion**) is used to identify the produced version.
This is much more useful than the time at which `make install` was run
since it unambiguously identifies a state of our repository.

  [wikipedia-rcs]: http://en.wikipedia.org/wiki/Revision_Control_System


## Produce documents having more than one source file

If we are working on a complex document, we certainly will split
our sources into several files.  Usually one file per chapter, or per
section, plus a main file containing the preamble and many
_input_ statements to instruct LaTeX to read all of the files
representing the document's contents.

Assume that our document is split into a main file `galley.tex`
and two other files `part1.tex` and `part2.tex`. Our `galley.tex`
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


## Produce documents including METAPOST figures

Modules `latex.doc.mk` and `tex.doc.mk` comes with a nice support for
[METAPOST][metapost-home]. This is something worth noting, since
METAPOST is often the right tool to be used for drawing figures
appearing in TeX documents, but support for it is missing in many GUI
editors for LaTeX.

These modules assume that METAPOST source does not manipulate the
values of the variables `prologues`, `outputtemplate` and
`outputformat`.  They set-up these variables so that:

```metapost
prologues := 3;
outputtemplate := "%j-%c.mps";
```

These setting are appropriate when working with modern versions of
METAPOST and the *graphicx* LaTeX package.  The first declaration
parametrises the inclusion of fonts in the output, while the second
reconfigures the names used for output.

Assume we prepared illustrations for our article with METAPOST,
and split our illustrations into two files `illustr1.mp` and
`illustr2.mp`. To let `latex.doc.mk` handle the production of our
figures, we add _SRCS_ statements to your `Makefile`:

```makefile
DOCUMENT=		galley.tex
SRCS=			part1.tex
SRCS+=			part2.tex
SRCS+=			illustr1.mp
SRCS+=			illustr2.mp
.include "latex.doc.mk"
```

We then type in _make_ at the shell prompt. The `latex.doc.mk` will
figure out how many illustrations are present in each file, and
produce the image files required by our _TEXDEVICE._  For instance, if
our _TEXDEVICE_ is _pdf,_ and `illustr1.mp` contains two figures
introduced by `beginfig(1)` and `beginfig(2)`, we end up with four files

```console
% ls *.{mps,pdf}
illustr1-1.mps
illustr1-1.pdf
illustr1-2.mps
illustr1-2.pdf
```

The files ending in `.mps` are intermediary files in PostScript format,
and the remaining ones are PDF files suited for inclusion
in our document.

Using the _graphicx_ package, inclusion is as easy as it should be:

```latex
\includegraphics{illustr1-1}%
```

_Discovering METAPOST._ It seems that many people do not know about
METAPOST.  For those interested in discovering it, the first good news
is that this program is included by many (if not all) TeX
distributions, hence it is probably already available on their system.
The second good news is that they can easily find plenty of
information and examples of its use on the WWW. For instance, the
[TeX users group][metapost-tug] has a page on its website devoted to
this tool. The list they will find there is pretty long, so let me add that
I especially like the [introduction written by André Heck][metapost-heck],
it might also be a good starting point for them.

  [metapost-heck]: http://staff.science.uva.nl/~heck/Courses/mptut.pdf
  [metapost-home]: http://cm.bell-labs.com/who/hobby/MetaPost.html
  [metapost-tug]:  http://www.tug.org/metapost.html


##  Produce standalone figures with METAPOST

The module `mpost.doc.mk` allows the creation of METAPOST pictures in
the following formats: Encapuslated PostScript, PDF, PNG and SVG.
Assume that we prepared two series of illustrations in files
`illustr1.mp` and `illustr2.mp` and we want to produce them in each of
the aforementioned formats.  The corresponding `Makefile` is:

```makefile
DOCUMENT=		illustr1.mp
DOCUMENT+=		illustr2.mp
MPDEVICE=		eps pdf png svg
.include "mpost.doc.mk"
```


## Produce documents including BibTeX bibliographies

**BSD Owl Scripts** support the preparation of bibliographies with BibTeX.
First, we must be sure that the program TeX will find the
bibliographic databases we enumerated in our document with
_bibliography_ statements.  It is customary to gather these bibliographic
databases in some directory, for instance _${HOME}/share/bib_.  To let
BibTeX find these files, it is enough to add _${HOME}/share/bib_ to
the content of the variable _BIBINPUTS_.  If our bibliographic
databases are scattered among several directories, we just need to
let each of them appear in the value of the variable _BIBINPUTS_:

```makefile
DOCUMENT=		galley.tex
SRCS=			part1.tex
SRCS+=			part2.tex
BIBINPUTS=		${HOME}/share/bib
BIBINPUTS+=		${.CURDIR}/morebib
USES+=			bibtex
.include "latex.doc.mk"
```

We note that the _make clean_ mantra will leave intact the BBL file
produced by BibTeX.  This is because we sometimes need to send this
file to our publisher rather than an unprocessed BibTeX database.
Hence the _make clean_ or _make distclean_ will leave our document's
directory in the state we want to have it when we want to
redistribute it. To get rid of the BBL file as well, we need to use
the more powerful mantra _make realclean_.


## Produce an index for a LaTeX document

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
your documents, we might have some reasons to keep several documents
in the same directory.  We have your reasons and they are probably
good ones, so **BSD Owl Scripts** will do its best to help us.

We assume that we have two documents whose sources are living in the
same directory, let's say an article and an abridged version of this
article. These manuscripts share a macro file `macro.tex`, but are otherwise
rather independent from LaTeX's point of view.  The text of the article
is split across two files, `section1.tex` and `section2.tex`. The
abridged version has just one text file `summary.tex`.
The `Makefile` we use looks like this:

```makefile
DOCUMENT=		article.tex
DOCUMENT+=		summary.tex

SRCS=			macros.tex

SRCS.article.tex=	section1.tex
SRCS.article.tex+=	section2.tex

.include "latex.doc.mk"
```


## Produce documents having automatically generated parts

Assume we are working on a document containing a table whose
content is likely to change several times and will need to be
updated.  Such a table could be a budget:  when the corresponding
project evolves, so does the budget.  It can be quite tedious to
type in a table in LaTeX, and updating it might even be trickier.
In such a situation, it is a good idea to write a program
reading the raw data of our table and writing a LaTeX table
displaying our data and everything we want to compute from it.  Such
a program is usually very easy to write, because we only need to deal
with text files all of the time.  The **awk** programming language
could be a natural choice here but actually, almost any programming
language would fit pretty neatly.

So we have gathered the raw data of our table in the file `table.raw`
and written a small filter `gentable` that will read that table data
and write for us a LaTeX table on its standard output.  In our
manuscript, we use the name _table_ to refer to the file containing
the generated table. Here is our `Makefile`:

```makefile
DOCUMENT=		galley.tex

table.tex: gentable table.raw
	./gentable < table.raw > table.tex

REALCLEANFILES+=	table.tex

.include "latex.doc.mk"
```

If we send your files to someone else, he will maybe not want to
run our program `gentable`, so it is better to list `table.tex` in
_REALCLEANFILES_ rather than in _CLEANFILES_: we can clean your directory
with `make clean`, archive its contents and send the archive to someone
else without handling the generated `table.tex` in a special way.

Of course, we can compute some text or a METAPOST picture, or
pretty-print a piece of code, or whatever, instead of generating a
table!

Note that if you take advantage of the [OBJDIR](Objdir) feature of
**BSD Owl Scripts**, the production rule for `table.tex` should actually be:

```makefile
table.tex: gentable table.raw
	${.CURDIR}/gentable < ${.ALLSRC:M*.raw} > ${.TARGET}
.include "latex.doc.mk"
```

The special variables _.CURDIR,_ _.ALLSRC_ and _.TARGET_ are aware of
the mechansisms involved in the use of [OBJDIR](Objdir).


## Deal with documents whose source spans across several directories

Some workflows may prescribe that our source files are not located
in a single directory, but disseminated across the file system.

A reason for doing this could be that our organisation uses a custom
document class for its letters, where some picture appears.  We do
not want to copy the picture file in each of the folders hosting our
letters, nor do we want to have a symbolic link to the picture in
each of our directories because the file is irrelevant to our work:
we just want to not even know anything about the existence of this
picture.  The solution to this
problem is to rely on the _TEXINPUTS_ variable, its content is a list
of directories searched by TeX for its input files.

Another reason motivating the dissemination of source files in
several directories could be the preparation of a large document such as a
book.  If the files for each chapter are in separated directories, it
is easy to process an isolated chapter with LaTeX during the
preparation of the manuscript, for the purpose of proofreading.
TeX must find all these files when it processes the main file
including all the chapters, which is achieved by setting _TEXINPUTS_
to an appropriate value, as explained in the sequel.

We can set the _TEXINPUTS_ variable in our environment or in our
`Makefile`, or even write a custom `Makefile` template including this
setting.  The role of this variable for TeX is pretty similar
to the role of the _PATH_ environment variable for the shell.

Assume that the picture visually impersonating our organisation
is saved in _${HOME}/share/texmf/tex/organisation/visual.eps_.
In order to let TeX look for files in the folder containing the
picture, we add a _TEXINPUTS_ statement to our _Makefile_, like
this:

```makefile
DOCUMENT=		galley.tex
TEXINPUTS=		${HOME}/share/texmf/organisation
.include "latex.doc.mk"
```

If we now run _make_ in the folder containing this `Makefile`, we
will see an output similar to the following in our terminal:

```console
% make
make build
===> Multipass job for galley.pdf (aux)
env TEXINPUTS=".:${HOME}/share/texmf/organization:" pdflatex galley.tex
This is pdfeTeX, Version 3.141592-1.21a-2.2 (Web2C 7.5.4)
…
```

Let us take a look at the _TEXINPUTS_ assignment which is part of the
`env` command.  Its difference with respect to the declaration in the
`Makefile` above means that TeX will also look for files in the
current directory (this is what the initial dot stands for) and all
standard TeX locations (this is what the final colon stands for).

If we want to have absolute control on the value of _TEXINPUTS_, we
must add the assignment _USES+=texinputs:strict_ in our `Makefile`.
If it reads this statement **BSD Owl Scripts** will refrain from
adding the initial dot and the final colon to our `TEXINPUTS`
declaration.

The supporting macros for METAPOST also understand _TEXINPUTS_ and
_USES+=texinputs:strict_.  There is an analogous variable _MPINPUTS_
governing the look up of METAPOST input files, it is accompanied with an
_USES+=mpinputs:strict_ option.  If we want to have our TeX program and
our METAPOST program to be run with different values for _TEXINPUTS_,
we can pass the correct value to METAPOST through the _MPTEXINPUTS_
variable, this variable is also accompanied by an
_USES+=mptexinputs:strict_ option.


## Deal with a huge number of documents

We demonstrate how to use the `bps.subdir.mk` module to organise a
collection of documents.  For the purpose of the example, we assume
that we are preparing an electronic journal and want to distribute
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

To orchestrate the preparation of all our articles with
**BSD Owl Scripts** we just need to write additional `Makefile`s:

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
