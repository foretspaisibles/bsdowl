# Configuration profiles

Configuration profiles can be defined to build a software package
using different options.

A common application is to build with a _Debug_ configuration profile
when elaborating the software package and build with a _Release_
configuration profile when time has come to prepare software packages.
The first profile can build objects with debugging symbols and other
useful similar information while the second can produce an optimised
version of the product programs.  A second applications is to compare
several configuration profiles to experimentally determine which leads
to the most efficient build according to a given benchmark.


## Defining a configuration profile

Configuration files can be stored in the directory pointed to by the
variable `PACKAGELIBRARYCONFIGURATION` whose implicit value is
`${SRCDIR}/Library/Configuration`.

If the variable `CONFIGURATION` is defined then a file
`${CONFIGURATION}.mk` containing the corresponding settings must exist
in the configuration specific configuration file library.  This file
is then processed by each module of the package.  An error is
triggered if this file does not exist.


## Working with several configuration profiles

To work with several configuration profiles, it is advised that the
[OBJDIR](Objdir) mechanism is configured so that the variable
`${CONFIGURATIONDIR}` is part of the objdir-path and of `DESTDIR` or
`PREFIX` if we also want to use the `install` target.

It is then possible to build concurrently the software package using
several distinct configuration profiles and to benchmark the obtained
products to compare them.
