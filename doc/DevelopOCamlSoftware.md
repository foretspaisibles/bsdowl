# Develop OCaml Software

On this page, you will learn how to use **BSD Owl Scripts** to:

 - Compile and install simple OCaml programs.
 - Compile and install simple OCaml libraries.
 - Prepare and install documentation generated with **ocamldoc**.
 - Prepare and install a custom toplevel.
 - Generate lexers and parsers with **ocamllex** and **ocamlyacc**.
 - Use third party libraries in your programs.
 - Generate objects with debugging symbols.
 - Generate objects with profiling information.
 - Use **autoconf** in your project.
 - Organise a complex project in several directories.
 - Produce GPG-signed tarballs.
 - Simultaneously build a project with various configurations.


## Compile and install simple OCaml programs

We assume we have a written really simple program **wordcount**, our
own implementation of the Unix™ `wc(1)` utility.  The source code is
held by a single file `wordcount.ml`.


### The first time

We create a directory to hold our files and put our source there.
Along the source, we prepare a `Makefile` with the following content:

```makefile
PROGRAM=		wordcount
.include "ocaml.prog.mk"
```


### Building

We can now `make` our program and produce a `wordcount` binary.  The
complete output of the make process looks like this:

```console
make configure
make depend
ocamldep wordcount.ml > .depend
make build
ocamlc -c -o wordcount.cmo wordcount.ml
ocamlc -o wordcount.byte wordcount.cmo
cp wordcount.byte wordcount
make doc
make test
```

When we call `make` without argument it is the same thing as
`make all` which decomposes as the sequence:

    make configure
    make depend
    make build
    make doc

Some steps are not connected to any shell commands in the special case
taken as example, but they can have command attached to them in more
complicated projects.  We can test our program, edit it and re-`make`
it.


### Installing

Once we are satisfied with the results, we can install it with
`make install`.  The program **make** will call **su** to gain
root privileges and install the program under `/usr/local`,
the value of *PREFIX*

```console
% make install
===> Switching to root credentials for target (install)
Password:
/usr/bin/install -c -d /usr/local/bin
install -o root -g wheel -m 555 wordcount /usr/local/bin
```

We can verify the value of the *PREFIX* variable, or any other
variable, with `make -V` as in

```console
% make -V PREFIX
/usr/local
```

If we want to install our program to another location like
`${HOME}/bin` we only need to change the *PREFIX*.  The prefix
selection is usually left to the `configure` script of a project,
but, for this simple example, we will only add a `PREFIX=${HOME}`
assignment to our `Makefile`:

```makefile
PROGRAM=		wordcount
PREFIX=			${HOME}
.include "ocaml.prog.mk"
```

The order of variable declarations is not important but they have to
come before the `.include` line.  While this step can sometimes be
skipped, it is a good habit to `make clean` after changing the
configuration of a package.

```console
% make clean install
…
/usr/bin/install -c -d /home/michael/bin
install -o michael -g michael -m 550 wordcount /home/michael/bin
```

Note that since we have write access to the *PREFIX* directory, it is
not necessary to gain root privileges for this installation.


### Cleaning

Once we are done, we can remove object code from the directory with

```console
% make clean
rm -f wordcount.cmo wordcount.cmi wordcount.cb wordcount
```

If we look closely, we will notice that the `.depend` file is not
removed:

```console
% ls -A
.depend      Makefile     wordcount.ml
```

This is on purpose, and if we also want to get rid of the `.depend`
file we can use the more powerful mantra

```console
% make realclean
rm -f wordcount.cmo wordcount.cmi wordcount.cb wordcount
rm -f .depend
```


### Several source files

If our program consists of several files `ancillary.ml` and
`application.ml`, we need to list them in the *SRCS* variable, as in:

```makefile
PROGRAM=		wordcount
SRCS+=			ancillary.ml
SRCS+=			application.ml
.include "ocaml.prog.mk"
```

When we list explicitly source files in the *SRCS* variable, we are
not obliged to use the same name for our source file and our program,
so if we decided to use the name `main.ml` instead of `wordcount.ml`
our `Makefile` would be

```makefile
PROGRAM=		wordcount
SRCS=			main.ml
.include "ocaml.prog.mk"
```

While dependencies between modules are computed with `ocamldep` so
that modules are compiled as needed, the order in which the files are
listed in *SRCS* is used by the linker.  It is thus important to list
files in an order suited to the linking phase.


### Interfaces without implementation

If our implementation files are accompanied by interface files, these
are automatically detected and handled appropriately.  It is also
possible to compile a program against a module without implementation,
by listing the implementation file in the *SRCS* variable.  With the
`Makefile`

```makefile
PROGRAM=    wordcount
SRCS+=      ancillary.mli
SRCS+=      application.ml
.include "ocaml.prog.mk"
```

we can compile `application.ml` using the interface defined in
`ancillary.mli` without having implemented the interface.  Of course,
we will not be able to link `wordcount` but this allows to experiment
with the interfaces before deciding to implement it.


## Compile and install simple OCaml libraries

We now assume that we have a really simple OCaml library `newton`
consisting of an implementation file `newton.ml` and an interface file
`newton.mli`.


### The first time

The corresponding `Makefile` is then

```makefile
LIBRARY=		newton
SRCS+=			newton.ml
.include "ocaml.lib.mk"
```

Note that it is mandatory to list all implementation files in the
*SRCS* variable: in contrast to the module `ocaml.prog.mk` used to
compile OCaml programs, the module `ocaml.lib.ml` does not try to
automatically add the obvious `newton.ml` to our library.  This is
because libraries are essentially archive files and we are expected to
explicitely list files that are to be put in the archive.


### Building

As for programs, we can then `make` the library:

```console
% make
make configure
make depend
ocamldep  newton.ml newton.mli > .depend
make build
ocamlc -c -o newton.cmo newton.ml
ocamlc -a -o newton.cma newton.cmo
make doc
```


### Installing

we can now test our library and if we are satisfied, decide to
install it with `make install`.  The library will be installed in
`${LIBDIR}` that is

```console
% make -V LIBDIR
/usr/local/lib/ocaml
```

unless we selected another *PREFIX* as described above in _Compile
and install simple OCaml programs._  Alternatively, we can define a
*PACKAGE* name and library files will go in
`${PREFIX}/lib/ocaml/site-lib/${PACKAGE}` as in the following example:

```console
% make PACKAGE=mypackage install
===> Switching to root credentials for target (install)
Password:
/usr/bin/install -c -d /usr/local/lib/ocaml/site-lib/mypackage
install -o root -g wheel -m 444 newton.cma /usr/local/lib/ocaml/site-lib/mypackage
install -o root -g wheel -m 444 newton.cmi /usr/local/lib/ocaml/site-lib/mypackage
```


### Cleaning

Finally, we can `make clean` or `make distclean` our working
directory.


### Ad-hoc tests

Assume that we have written a simple program `test_newton.ml` that
we use to test our library.  We can then use a command line like

```
% make && ocaml newton.cma test_newton.ml
```

to rebuild our library and run our test with a single command line.
However each developer action should be doable in a single
command, which allows to focus on the task _run the test_ instead of
of the steps involved in the task.  Here is how we can define an
ad-hoc `test` target in the `Makefile`:

```makefile
LIBRARY=		newton
SRCS+=			newton.ml

test: newton.cma .PHONY
	ocaml newton.cma test_newton.ml

.include "ocaml.lib.mk"
```

The two new lines read as “in order to perform the _test_ please
refresh `newton.cma` and call `ocaml newton.cma test_newton.ml`.  The
`.PHONY` keyword tells `make(1)` that the target _test_ will not
produce a file called `test`, but rather defines a task to perform.
We can then `make test`:

```console
% make test
ocamlc -c -o newton.cmi newton.mli
ocamlc -c -o newton.cmo newton.ml
ocamlc -a -o newton.cma newton.cmo
ocaml newton.cma test_newton.ml
06   1.00000000
05   2.00000000
04   1.66666667
03   1.61904762
02   1.61803445
01   1.61803399
00   1.61803399
```

The lines starting with numbers are the output of the test, it
computes the golden ratio using Newton's method.


### META file

If we have prepared a META file so that our library can be found by
`ocamlfind(1)` we only need to include `ocaml.meta.mk` right before
the `ocaml.lib.mk`.  If for some reason, we prefer having the `META`
file in its own directory, a sample `Makefile` would be

```makefile
LIBDIR?= ${PREFIX}/lib/ocaml/site-lib${PACKAGEDIR}
.include "ocaml.meta.mk"
```


### Packed modules

We might prefer producing a packed module instead of a library. The
setup is very similar to the one we use for a library:

```makefile
PACK=			libNewton
SRCS+=			newton.ml
.include "ocaml.pack.mk"
```

## Prepare and install documentation

The generation of documentation with **ocamldoc** is supported.  We
build over the first **newton** library example and assume the file
`newton.mli` contains documentation annotations that can be used by
`ocamldoc`.  We can edit our `Makefile` as follows:

```makefile
LIBRARY=		newton
SRCS+=			newton.ml
USES+=			ocamldoc:odoc,html

ODOC_NAME=		newtontk
ODOC_TITLE=		Newton's method
.include "ocaml.lib.mk"
```

Setting `USES+=ocamldoc:odoc,html` tells `ocaml.lib.mk` it should use
`ocamldoc` to generate on-line documentation, the *ODOC_NAME* is an
identifiant used to construct file names for the output, and the value
of *ODOC_TITLE* is used as title in the generated documentation.  This
latter variable is not mandatory and if we feel lazy, we can left it
uninitialised. We are now ready to `make` everything, which will
rebuild the library and generate the documentation:

```console
% make
make depend
make build
ocamlc -c -o newton.cmi newton.mli
ocamlc -c -o newton.cmo newton.ml
ocamlc -a -o newton.cma newton.cmo
make doc
ocamldoc -t "Newton's method" -dump newtontk.odoc newton.ml newton.mli
rm -R -f newtontk_html.temp newtontk_html
mkdir newtontk_html.temp
ocamldoc -t "Newton's method" -html -d newtontk_html.temp newton.ml newton.mli
mv newtontk_html.temp newtontk_html
```

The documentation generation step has two products, an `ocamldoc` dump
that we can use in other `ocamldoc` runs with the `-load` option and a
directory `${ODOC_NAME}_html` holding the HTML generated
documentation.  We can tune the products we want to generate by
setting appropriately the arguments of the `USES+=ocamldoc` assignment
`ocaml.odoc.lib` file.  There we will also see how to tune the
generated output by adding a custom CSS file or a charset other than
ISO-8859-1 in our input files.

If we want to rebuild the library without rebuilding the
documentation, we can use the `build` target instead of the `all`
target implied by an empty list of arguments to `make`, as in

```
% make build
ocamlc -c -o newton.cmi newton.mli
ocamlc -c -o newton.cmo newton.ml
ocamlc -a -o newton.cma newton.cmo
```

Conversely `make doc` will only regenerate the documentation.


## Prepare and install a custom toplevel

Here is an example of `Makefile` that will allow you to prepare a
toplevel linked against the `unix` and `str` libraries and the
`initialise_toplevel` module:

	TOPLEVEL = toplevel
	SRCS = initialise_toplevel.ml
	LIBS = unix
	LIBS+= str
	.include "ocaml.toplevel.mk"

There is an interface to options several of `opcamlmktop` please refer
to the `ocaml.toplevel.mk` file.

**Note** We would like to provide a more capable and useful toplevel
production support. See this ticket:

  https://bitbucket.org/michipili/bsdowl/issue/7/powerful-ocamltoplevelmk


## Generate lexers and parsers

The standard tools **ocamllex** and **ocamlyacc** are supported by
**BSD Owl Scripts**.  In order to interpret and compile lexers and
parsers, we only need to list them as sources of our program as in
the following example:

```makefile
PROGRAM=		minibasic

SRCS =			main.ml
SRCS+=			basic_types.ml
SRCS+=			basic_parser.mly
SRCS+=			basic_lexer.mll

.include "ocaml.prog.mk"
```

If we wrote interface files for the generated implementation files,
these will automatically be generated.


## Use third party libraries

Linking against third party libraries distributed with a `META` file
compatible with **ocamlfind** is supported through the *EXTERNAL*
variable:

```makefile
PROGRAM=		wordcount

SRCS+=			extras.ml
SRCS+=			wordcount.ml

EXTERNAL+=		ocaml.findlib:str

.include "ocaml.prog.mk"
```

Predicates can be added with the *PREDICATES* variable, they are
passed to **ocamlfind** with the `-p` flag.

Libraries which are not supporting **ocamlfind** can also be used,
with a little more work.

```makefile
PROGRAM=		golden_ratio

SRCS=			main.ml

EXTERNAL+=		ocaml.findlib:nums
EXTERNAL+=		ocaml.lib:newton
EXTERNAL+=		ocaml.lib:fibonacci

.include "ocaml.prog.mk"
```

In order to link our program against these libraries, **BSD Owl
Scripts** still needs to know which archives to use and where to find
them.  This information is usually determined by the `configure`
script and written to the file `Makefile.config` in the following format:

```makefile
_EXTERNAL_ocaml.lib_newton_DIR=/usr/local/lib/newton
_EXTERNAL_ocaml.lib_newton_BYTE=newton.cma
_EXTERNAL_ocaml.lib_newton_NATIVE=newton.cmxa

_EXTERNAL_ocaml.lib_fibonacci_DIR=/usr/local/lib/
_EXTERNAL_ocaml.lib_fibonacci_BYTE=fibonacci.cma
_EXTERNAL_ocaml.lib_fibonacci_NATIVE=fibonacci.cmxa
```


## Generate objects with debugging symbols

Generation of objects containing debugging symbols is controlled by
the `USES+= debug` knob.  When it is used, all objects,
executables and libraries are compiled or linked with the `-g` flag.


## Generate objects with profiling information

Generation of objects containing debugging symbols is controlled by
the `USES+= profile` knob.  When it is used, all objects,
executables and libraries are compiled or linked with profiling
front-ends of the OCaml compiler.


## Use autoconf in our project

We show how to use **autoconf** to let the user configure
installation paths for our program.  The `./configure` script
generated by the following `configure.ac` will produce a
file `Makefile.config`
and a `standardDirectory.ml` file by replacing variables in
`Makefile.config.in` and `standardDirectory.ml.in`.

```
AC_INIT([program.ml])
AC_CONFIG_FILES([standardDirectory.ml])
AC_CONFIG_FILES([Makefile.config])
AC_OUTPUT
```

It is better to produce an auxiliary `Makefile.config` file with
`autoconf` instead of the primary `Makefile` so that the project tree
remains in a usable state, even if it is not configured.

There is `autoconf` macros available for OCaml-based projects, that
will identify OCaml tools, and test for the availability of libraries:

	http://forge.ocamlcore.org/projects/ocaml-autoconf/


## Organise a complex project

We show how to use **BSD Owl Scripts** to organise the build of a
small project consisting of two libraries and a program: a first
library `newton` provides a service to compute the golden ratio using
Newton's method, a second library `fibonacci` offers a computation
method based on Fibonacci numbers.  The `golden_ratio` program uses
these two service to compare the approximations.


### Simple aggregate and delegate pattern

First, create a master directory and three subdirectories `newton`,
`fibonacci` and `golden_ratio` holding our software components.
Along with the sources, these folder contain `Makefile`s as described
in _Compile and install simple OCaml libraries_ and _Use third party
libraries_ above.  Once we are done, create the master `Makefile` in
the master directory:

```makefile
SUBDIR+=	fibonacci
SUBDIR+=	newton
SUBDIR+=	golden_ratio

.include "generic.subdir.mk"
```

The special `generic.subdir.mk` will delegate most targets to the
subdirectories listed in *SUBDIR*.  Thus we can `make` to produce
libraries and program, `make install` and `make clean` also work
similarly.


### Projects

Besides delegating the common targets `all`, `install` and `clean`
(for the most importants), there is much more project related tasks
that can be handled my `Makefiles`.  We provide a directives file
`generic.project.mk` which is much more powerful than `generic.subdir.mk` and
can be used to support our project development by automating other
tasks.  We can turn the previous `generic.subdir.mk`-based `Makefile`
into a project in two steps.

We first add declaration of a *PACKAGE*, a *VERSION* and an
*OFFICER* variables—and of course editing the `.include` line:

```
PACKAGE=	golden_ratio
VERSION=	1.0.0
OFFICER=	michipili@gmail.com

SUBDIR+=	fibonacci
SUBDIR+=	newton
SUBDIR+=	golden_ratio

.include "generic.project.mk"
```

The *OFFICER* identifies the GPG-key of the release office, which is
used to sign release tarballs. After this first step, we replace the
assignements to *SUBDIR* as follows:

```
PACKAGE=	golden_ratio
VERSION=	1.0.0
OFFICER=	michipili@gmail.com

MODULE=		ocaml.lib:fibonacci
MODULE+=	ocaml.lib:newton
MODULE+=	ocaml.prog:golden_ratio

.include "generic.project.mk"
```

The *MODULE* variable is similar to *SUBDIR* in that it implements a
delegate pattern.  But besides implementing this pattern, it is aware
of the products produced by the modules it enumerates and uses it to
generate adequate linking information for libraries and programs.


### Preparing project tarballs

Issuing `make dist` will `distclean` the master directory and prepare
source tarballs in *PROJECTDISTDIR* for several archive formats.  The
name of the archive is deduced from *PROJECT* and *VERSION*.

Some files present in the source directory can be filtered out from
the tarball distribution by adding them to the *PROJECTDISTEXCLUDE*
variable.

Additional files that should be copied in the distribution
directory—as a `ChangeLog` or `README`—can be specified in
*PROJECTDIST*.


Finally, it will try to sign tarballs with GPG, using the key
identified by *OFFICER*. The signature file are stored in
*PROJECTDISTDIR* along the distfiles produced in the last step.
Additional files that should be signed can be specified in
*PROJECTDISTSIGN*.


### Entering developer subshell

The developer subshell is a normal interactive shell where some
environement variables are set up to ease development.  They are most
useful if our project defines a project library, which is located in
the `Library` directory inside the project master directory, or in any
other location specified by *PROJECTLIBRARY*.

If the project library contains a `Make` or `Mk` directory, or if the
project master directory contains a `Mk` subdirectory, these are added
to the lookup path of `make`.  Thus, it is very easy to
[define a library](ProjectLibrary) of `Makefile` for the various products of
our project.

If the project library contains an `Ancillary` directory, it added to
the path, so that the `${PROJECTLIBRARY}/Ancillary` is a convenient
place to [store scripts](ProjectLibrary) used in our project.


### Manage compilation configurations

It is common to use several configuration sets when working on a
project: sometimes the classical triad _debug_, _profile_ and
_release_ are enough, sometimes more complicated setups are required.
While there is no special provision (yet) for managing the compilation
configurations in a project it is easy to implement.  Here is how to:

- Define several compilation setups.
- Simultaneously prepare products with different distinct setups.

Assume we have three compilation setups _debug_, _profile_ and
_release._ For each of these setup we create a corresponding
`Makefile`, so `Makefile.debug`, `Makefile.profile` and
`Makefile.release` stored in *PROJECTLIBRARYMAKE*.

Once we have created these files, we only need to export

    MAKEINITRC=Makefile.debug

to work in the _debug_ compilation setup, for instance. Before
changing this environment variable, it is advisable to `clean` our
project tree—or to take advantage of the more advanced feature
`MAKEOBJDIR`.

The simultaneous build of our products with distinct compilation
setups is achieved by adding these lines to our
master `Makefile` (before the `.include` line):

```makefile
PROJECTSETUP=	debug profile release

universe:
.for setup in ${PROJECTSETUP}
	${ENVTOOL} MAKEINITRC=Makefile.${setup} MAKEOBJDIR=${.CURDIR}/obj/${setup} ${MAKE} all
.endfor
```

Issuing `make universe` will then create an `obj` directory containing
subdirectories `debug`, `profile` and `release` holding compilation
products.

Depending on our workflow, there might be more useful ways to combine
these features together.


### Prepare and install documentation for complex projects

We can use `ocamldoc` to generate the documentation of a large
project, which sources span across several directories.

First, we require `ocamldoc` to generate an *ocamldoc dump* for each
subpackage, which is achieved by parametrising the *ODOC_FORMAT*
variable.  Here is how the `Makefile` of the `newton` library in our
`golden_ratio` project now looks like:

```makefile
LIBRARY=		newton
SRCS+=			newton.ml

USES+=			ocamldoc:odoc
ODOC_NAME=		newtontk
ODOC_TITLE=		Newton's method

.include "ocaml.lib.mk"
```

The implicit format list used for `USES+= ocamldoc` is `odoc,html` so
that the above setting merely inhibits the production of HTML
documentation for `newton`.  This documentation artefact is not useful
anymore, since it is a subset of the global documentation whose
production we are organising.

In the project master directory, create a `manual` directory and
create a `Makefile` there along these lines:

```makefile
ODOC_TITLE=		Golden Ratio

.include "ocaml.manual.mk"
```

As a final step, integrate the `manual` directory to our project by
appending it to the *MODULE* list in our master `Makefile`.  Making
`all` or `doc` will from now on produce HTML documentation!  The `all`
target is split as `configure depend build doc test` so, if we want
to skip documentation generation, we can use `make build` instead of
`make all` or `make`.
