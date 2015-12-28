# Develop Shell Scripts

This page describes the features of **BSD Owl Scripts** that are
useful when developping Perl scripts and Perl modules.  After
reading this page, you will know:

 - How to install a simple Perl program.
 - How to configure resource directories in Perl programs.
 - How to test your Perl program without installing it.
 - How to install simple Perl modules.

Minimal examples for a program and a library can be found under
[testsuite/script/test_perl][example-showconfig].

## Install a simple Perl program

As a Perl program is nothing more than a regular text file coming
with the whole *sha-bang* and installed somewhere in the path, there
is little processing required before installing these files.

A simple `Makefile` to install a Perl program looks like:

```Makefile
PROGRAM=		simple_perl_program.pl
.include "perl.prog.mk"
```

This will install `simple_perl_program.pl` as `simple_perl_program`
in `${BINDIR}`.  The `PROGRAM` variable can enumerate several programs
to install, ending with `.pl`.
If a file `simple_perl_program.1` or `simple_perl_program.8`
is found, it will also be installed as a compressed manual page.


## Configure resource directories in Perl programs

There is one processing actually taking place before Perl programs
are installed: variables like `@prefix@` are expanded to their values
as known to `make(1)`. These values are typically declared in the file
`Makefile.config` found at the root of the project, this file is expected
to be produced from a `Makefile.config.in` model by `./configure`.  The
variable `REPLACESUBST` contains the list of `@`-style variables which
should be replaced by their values as known by `make(1)`.  The variable
`REPLACESUBST` already contains the `PACKAGE` and `VERSION` variables, and
the standard directory variables.  This mechanism can be used to
convey values found by the `./configure` script to our program.  An
important example can be the path to the interpreter.

Note that this variable expansion also takes place in the prepraration
of manual pages.


## Test your Perl program without installing it

As a Perl-script developer, we do not want to repeatedly install a
script in order to test it.  Rather, we would like to test it without
installing it, and especially to run the script in a controlled
environment for automated testing.  This problem can be solved by
introducing a dedicated function to optionally initialise variables
from the environment, as in the following example:

```perl
sub ac_config_init
{
    if ($ENV{$_[0]}) {
        return $ENV{$_[0]};
    } else {
        return $_[1];
    }
}

my $prefix = ac_config_init('prefix', '@prefix@');
…
```

This example is used in the [sample Perl program][example-showconfig]
mentioned above.


With these declarations, the installed version of the script will use
the values supplied by the `./configure` script while a special
environment can easily be crafted for test purposes, so that running
the script does not require prealable installation.

Note that allowing the user to supersede directory variables in the
environment might rise a security issue.  The `sudo(8)` command can be
used to delegate privileges while maintaining a controlled
environment.


## Install Perl libraries

A simple `Makefile` requiring the installation of the Perl module
library `Module.pm` looks like:

```Makefile
LIBRARY=		Module.pm
.include "perl.lib.mk"
```

The files enumerated by `LIBRARY` are installed to `${PERLLIBDIR}`
which defaults to `${PREFIX}/lib/perl${PERLVERSION}${PERLPACKAGEDIR}`.
If a file `Module.3pm` or `Module.8pm` is found, it is installed as a
manual page.

The replacement of `@`-style variables _does not happen_ when
libraries of Perl routines are processed — but it still happens for
manual pages.  The recommanded calling convention for libraries, is
that the library client prepares all variables required by the library
to run correctly.

  [example-anvil]:      https://github.com/michipili/anvil
  [example-showconfig]: https://github.com/michipili/bsdowl/blob/master/testsuite/script/test_perl/showconfig.pl
