# Installation of man pages

The library `bps.man.mk` defines targets to build and install manual pages and
hooks them to the build and installation processes.

The list of manual pages to install must be conveyed by the *MAN*
variable. Other variables can be used to configure the process, as
described in `bps.man.mk`.

Modules building a program or a library or any product documented by a
manual page should lookup for manual pages to automatically add them
to the *MAN* variable.  For instance, a module building a program
`wordcount` should look for files `wordcount.1` and `wordcount.8` and
add them to *MAN* if they exist.
