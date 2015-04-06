# Description of software packages

## Simple packages

A [package](BuildConcepts) consists of one or several modules. Because
our system is non bureaucratic, an isolated module is automatically
promoted to a package.


## Package identification

**PACKAGE**
 The name of a package.

   It must be a sequence of characters `[-+_A-Za-z0-9]`.


**VERSION**
 The version of a package.

   It should have the form `MAJOR.MINOR.PATCHLEVEL` or
   `MAJOR.MINOR.PATCHLEVEL-IDENTIFIER` (for pre-releases).
   It defaults to 0.1.0-current.

**OFFICER**
 The release engineering officer.

  This is the GPG identity used to sign the tarballs. It defaults to
  `${EMAIL}` if this environment variable is set or to
  `${USER}@${HOST}`.


## Modules and external dependencies


**MODULE**
 The list of modules belonging to the package.

  The list consists of pairs `module:path` where `module` is a BSD Owl
  module like `ocaml.prog` or `latex.doc` or `c.lib` and path is the
  path to the directory corresponding to the module with respect to
  `${SRCDIR}`, the root of our source tree.


**EXTERNAL**
 The list of external dependencies of the package.

  The list consists of pair `consumer:resource` where `consumer` is a
  keyword identifying the type of the external resource and `resource`
  is its symbolic name.


## Environment

**DESTDIR**
 A directory to prepend to PREFIX, only when copying files.

  Usually not set. Useful to install in a file system whose root is not
  the root of the full file system.


**PREFIX**
 The installation prefix of the package.

  Usually `/usr /usr/local`, `/opt/local` or `/home/joeuser`.  It
  must be set at configuration time.


**EXEC_PREFIX**
 The installation prefix for binaries of the package.


**BINDIR**
 The directory for installing executable programs that users can run.


**SBINDIR**
 The directory for installing executable programs used by sysadmins.


**LIBEXECDIR**
 The directory for installing executable programs to be run by other programs.


**DATAROOTDIR**
 The root of the hierarchy for read-only architecture-independent data files.


**DATADIR**
 The directory for installing idiosyncratic read-only
 architecture-independent data files for this program.


**SYSCONFDIR**
 The directory for installing read-only data files that pertain to a
 single machine–that is to say, files for configuring a host.


**SHAREDSTATEDIR**
 The directory for installing architecture-independent data files
 which the programs modify while they run.


**LOCALSTATEDIR**
 The directory for installing data files which the programs modify
 while they run, and that pertain to one specific machine.


**RUNSTATEDIR**
 The directory for installing data files which the programs modify
 while they run, that pertain to one specific machine, and which need
 not persist longer than the execution of the program—which is
 generally long-lived, for example, until the next reboot


**INCLUDEDIR**
 The directory for installing header files to be included by user
 programs with the C ‘#include’ preprocessor directive.


**DOCDIR**
 The directory for installing documentation files (other than Info) for
 this package.


**INFODIR**
 The directory for installing the Info files for this package.


**LIBDIR**
 The directory for object files and libraries of object code.


**LOCALEDIR**
 The directory for installing locale-specific message catalogues for this
 package.


**MANDIR**
 The top-level directory for installing the man pages for this package.


**MAKEOBJDIR**
 The location where build products should be placed.

  We want to support three settings:
  - the dirty setting where objects are stored in the source tree
  - the flat setting where objects are stored in a
    package/configuration/architecture specific directory
  - the hierarchical setting where objects are stored in a
    package/configuration/architecture specific file hierarchy replicating
    the source tree.

  In the flat and in the hierarchical setting, the actual value is
  CONFIGURATION dependant.


## Installation method

Credential switch with su, sudo.

  Should we support jails, chroot, ssh? It is probably not a serious
  limitation to require users to log on the remote host and perform
  there an actual installation.

  Note that some systems do not have a root user (e.g. Cygwin), this
  should be detected at configuration time. See #60.


## Build Configuration

A *build configuration* or *configuration* is a name like `Debug` or
`Release` which is used to read a file under Library/Configuration
where compilation flags can be adjusted.

A target architecture can also be specified for tools supporting
cross-compilation. This is done using a target triplet (actually 4let)
as described by Autotools.

**CONFIGURATION**
 The name of the configuration used.
