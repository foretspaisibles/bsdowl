# Concepts of our build system

Our build system allows the compilation and installation of simple and
complex pieces of software. The description of the software bing built
involves packages, modules and products.


## Software packages
A *software package* or shortly *package* is the largest hierarchical
unit of the description of the software that should be built.  The
complete description of a software packages consists of all the
programs, libraries, documents that should be built and copied to the
target system in order to install the software.  This description also
accounts for extra steps that should be taken to integrate the
software to its host environment, like triggering scripts indexing
documentation and similar steps.

Other common names for *software package* are *project* or *solution*.
The name *software package* or *package* is also used by the
GNU Autotools, it should not be confused with *packages*
used by *package management software* such as *pkg* on FreeBSD or
*apt* on Debian.


## Modules
A *module* is the smallest hierarchical unit of the description of the
software that should be built, it sits just above files in that
hierarchy.  Typical examples of modules consists of a C program
together with its manual pages, an OCaml library with its ocamldoc
generated documentation, a LaTeX class, or package documentation.

It is worth to note that a simple software package may consist of a
single module.  Also, each module can provide its own documentation
products but the software package as a whole may contain extra modules
producing documentation artifacts whose scope is not limited to a
specific module but may embrace several of them—typically the
full software package.

Software modules can depend on external programs, packages and
libraries.  They also can depend on other modules found within the
sofware package being built.


## Products
The *products* of a *module* are file system artifacts, like a single
file or a subtree of the file system.  These products are the actual
artifacts representing the software package in the host system.  The
installation procedure of the software package usually copies products
at appropriate places of the file-system but it may require to execute
additional actions, like the execution of scripts.
