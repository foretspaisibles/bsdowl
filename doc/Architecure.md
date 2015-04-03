# Handling architectures

## Detecting the architecture with autoconf

In order to detect the architecture of the host where you build your
package with `autoconf` we suggest the following setup:

1. Prepare a directory `Library/Autoconf` in your source directory.
2. Copy the files `install-sh`, `config.guess` and `config.sub`
   shipped with `automake`.
3. Add the statement `AC_CONFIG_AUX_DIR([Library/Autoconf])` to your
   `configure.ac`.
4. Add the statement `AC_CANONICAL_BUILD()` to your `configure.ac`.
5. Analyse the content of the variables `build`, and its three individual
   parts `build_cpu`, `build_vendor`, and `build_os` to map this
   triple to the architecture classification used by your package.
6. Use the `AC_SUBST` macro to define appropriately the
   `ARCHITECTURE_NATIVE` variable.


## Using architecture specific settings

Architecture specific configuration files can be stored in the
directory pointed to by the variable `PACKAGELIBRARYARCHITECTURE` whose
implicit value is `${SRCDIR}/Library/Configuration`.

If the variable `ARCHITECTURE` is defined then a file
`${ARCHITECTURE}.mk` containing architecture-specific settings must
exist in the architecture specific configuration file library.  This
file is then processed by each module of the package.  An error is
triggered if this file does not exist.

If a [configuration](Configuration) is used and the variable
`CONFIGURATION` is also defined, then a file
`${CONFIGURATION}_${ARCHITECTURE}.mk` might exist in the directory
pointed to by the variable `PACKAGELIBRARYCONFIGURATION`. This file is
optional.


## Using a cross-compiler

If available, a cross-compiler can be used to cross-compile a package.
By repeatedly calling `make build` with distinct values of
`ARCHITECTURE`, the same package can be built for several
architectures.

To do so, we only need to be sure that the [OBJDIR](Objdir) mechanism
is configured so that the variable `${ARCHITECTUREDIR}` is part of the
objdir-path and of `DESTDIR` if we also use the `install` target.


## Troubleshooting

The command `make display-architecture` prepares a report giving the
values of the variables used when handling architectures.
