# Develop Shell Scripts

This page describes the features of **BSD Owl Scripts** that are
useful when developping shell scripts and shell routines.  After
reading this page, you will know:

 - How to install a simple shell program.
 - How to configure resource directories in shell programs.
 - How to test your shell program without installing it.
 - How to install shell libraries.

Minimal examples for a program and a library can be found under
[testsuite/script/test_shell][example-showconfig].  The
[Anvil][example-anvil] project provides a more complete example.


## Install a simple shell program

As a shell program is nothing more than a regular text file coming
with the whole *sha-bang* and installed somewhere in the path, there
is little processing required before installing these files.

A simple `Makefile` to install a shell program looks like:

```Makefile
PROGRAM=		simple-shell-program.sh
.include "shell.prog.mk"
```

This will install `simple-shell-program.sh` as `simple-shell-program`
in `${BINDIR}`.  The `PROGRAM` variable can enumerate several programs
to install, ending with `.sh`, `.bash`, `.ksh`, `.csh`, `.awk` or
`.sed`. If a file `simple-shell-program.1` or `simple-shell-program.8`
is found, it will also be installed as a compressed manual page.


## Configure resource directories in shell programs

There is one processing actually taking place before shell programs
are installed: variables like `@prefix@` are expanded to their values
as known to `make(1)`. These values are typically declared in the file
`Makefile.config` found at the root of the project, this file is expected
to be produced from a `Makefile.config.in` model by `./configure`.  The
variable `REPLACESUBST` contains the list of `@`-style variables which
should be replaced by their values as known by `make(1)`.  The variable
`REPLACESUBST` already contains the `PACKAGE` and `VERSION` variables, and
the standard directory variables.  This mechanism can be used to
convey values found by the `./configure` script to our program.  An
important example can be the path to the interpreter, since shells
other than the Bourne shell do not need to have an installation path
which is consistent across all operating systems.

Note that this variable expansion also takes place in the prepraration
of manual pages.


## Test your shell program without installing it

As a shell-script developer, we do not want to repeatedly install a
script in order to test it.  Rather, we would like to test it without
installing it, and especially to run the script in a controlled
environment for automated testing.  This problem can nicely be solved
by using the shell `:` operator and the `:=` replacement modificator,
as in the following example:

```sh
: ${prefix:=@prefix@}
: ${exec_prefix:=@exec_prefix@}
: ${bindir:=@bindir@}
…
```

With these declarations, the installed version of the script will use
the values supplied by the `./configure` script while a special
environment can easily be crafted for test purpposes, so that running
the script does not require installation.

Note that allowing the user to supersede directory variables in the
environment might rise a security issue.  The `sudo(8)` command can be
used to delegate privileges while maintaining a controlled
environment.


## Install shell libraries

A simple `Makefile` requiring the installation of the shell routine
library `simple-library.subr` looks like:

```Makefile
LIBRARY=		simple-library.subr
.include "shell.lib.mk"
```

The files enumerated by `LIBRARY` are installed to `${SUBRDIR}` which
defaults to `${SHAREDIR}`.  If a file `simple-library.subr.3` or
`simple-library.subr.8` is found, it is installed as a manual page.

The replacement of `@`-style variables _does not happen_ when
libraries of shell routines are processed — but it still happens for
manual pages.  The recommanded calling convention for libraries, is
that the library client prepares all variables required by the library
to run correctly.  The library can use `:` constructs and `:?`
replacement modifiers to ensure it runs in a sane environment.


## Other useful resources

- *UNIX Shell Programming, 2nd edition* by Lowell Jay Arthur.
- [Shellcheck][shell-check], an online linter for shell scripts.
- A [list of obsolete or deprecated shell constructs][shell-obsolete]

  [example-anvil]:      https://github.com/michipili/anvil
  [example-showconfig]: https://github.com/michipili/bsdowl/blob/master/testsuite/script/test_shell/showconfig.sh
  [shell-check]:        http://www.shellcheck.net
  [shell-obsolete]:     http://wiki.bash-hackers.org/scripting/obsolete
