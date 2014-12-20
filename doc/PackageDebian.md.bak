# Package your software for Debian

This document covers the preparation of Debian packages for your
software package using **BSD Owl Scripts.**  After reading this document,
you will know:

 - How to configure your environment to start writing packages.
 - How to write the first version of your package.
 - How to update your package.

We assume that the package:

 - is built and installed using **BSD Owl Scripts;**
 - uses **git** as a source control management system.

We take as an example the preparation of a Debian package for
**[Anvil 0.3.0][anvil].**  This special example also

 - uses **GNU Autoconf** to discover the system it is running on;
 - has a `release` branch holding the latest release;
 - uses tags similar to `v1.0.0` to identify versions.

It should be easy to adapt the provided instructions to match other
settings.


**See Also:**
[Debian New Maintainers' Guide][debian-maintainer],
[Packaging with git][debian-git].


## Clone the repository

We clone the repository and let our shell visit it.

```console
% git clone git@github.com:michipili/anvil.git
% cd anvil
```


## Create the Debian branch

We cut out a `debian` branch off the `release` branch.  This branch
should hold all files required by Debian to produce a package.

``` console
% git checkout -b debian origin/release
```

As detailed below in the section *Staying up to date*, subsequent
releases happening on the `release` branch are to be merged on the
`debian` branch in order to prepare packages for the newer version.


## Create the Debian directory

The `debian` directory is used by the build system as a repository for
configuration files but also as a work directory.  We use the
`dh_make` program to initialise this directory.

```console
% dh_make --native -p anvil_0.3.0
% git add debian
% git commit -m "Create the Debian directory"
```

**See Also:**
[Debian New Maintainers' Guide, Chapter 2][debian-maintainer-chap2],
[dh-make(1)][debian-man-dh-make].



## Cleanup the Debian directory

The `dh_make` program fills the `debian` directory with a lot of
templates.  Most of the templates contain comments and are described
in the [Debian New Maintainers' Guide][debian-maintainer].  After a
quick inspection, we remove those which are not relevant.

```console
% cd debian
% git rm README*
% git rm anvil.cron.d.ex
% git rm anvil.default.ex
% git rm init.d.ex
% git rm manpage.* menu.ex {pre,post}{inst,rm}.ex
% git commit -m "Cleanup the Debian directory"
```


## Edit the control file

The control file holds most of the package meta-information.  The
contents of this file is described in details in
[Chapter 4][debian-maintainer-control] of *Debian New Maintainer's Guide.*
We proceed to the following actions:

- Set the Section
- Set Build-Depends
- Set Homepage
- Set Vcs-Git
- Set Vcs-Browser
- Set Depends
- Set Description

When we are done, we commit the resulting control file.


## Edit the copyright file

The copyright file contains, as its name suggests, copyright
information for the files found in the package.  In the simplest
cases, it is essentially a copy of the licence agreement.  The
[Chapter 4][debian-maintainer-control] of *Debian New
Maintainer's Guide* describes how to prepare this file.

When we are done, we commit the resulting copyright file.


## Edit the changelog file

This is a third file with other meta-information.  The most important
information it contains is the version information.  It is also
described in [Chapter 4][debian-maintainer-changelog] of *Debian New
Maintainer's Guide* describes how to prepare this file.


## Edit the rules file

The rules file is a GNU Makefile describing how to actually compile
the software.  All packages using **BSD Owl Scripts** will have a
rules file similar to the following:

```Makefile
#!/usr/bin/make -f
MAKETOOL=bmake -r -I/usr/share/bsdowl DESTDIR=$$(pwd)/debian/anvil

%:
	dh $@

override_dh_auto_configure:
	autoconf
	dh_auto_configure

override_dh_auto_build:
	${MAKETOOL} build

override_dh_auto_install:
	${MAKETOOL} install
	dh_installman

override_dh_auto_clean:
	${MAKETOOL} distclean

override_dh_auto_test:
	: Do nada
```

It assumes that the `configure` script is not under version control,
otherwise the target `override_dh_auto_configure` can be removed.  It
also assumes that our software package can be distcleaned without
having been configured before.


## Edit documentation index

The file anvil.doc-base is a documentation index that should briefly
describe installed documents.  The program `dh_make` created a
template that we need to edit, then commit.


## Edit the watch file

The watch file is used to automatically detect new versions of the
software, which is not mandatory but still nice to have.

```
version=3
opts=pgpsigurlmangle=s/$/.sig/ https://github.com/michipili/anvil/releases (?:.*/)?anvil-([\d\.]+).tar.(?:gz|bz2|xz)
```


## Configure git-buildpackage


Finally we configure the git buildpackage subcommand, to match the
conventions used in our repository, which are slightly different from
the default conventions.  We create the file `gbp.conf` with the
following contents:


```
[DEFAULT]
upstream-branch = release
upstream-tag = v%(version)s
debian-branch = debian
debian-tag = debian/v%(version)s
```

Once we commit this file, the package can finally be created with `git
buildpackage`.


## Staying up to date

Once a version 0.4.0 of our **anvil** software package is merged into
the `release` branch, producing an updated package can be as easy as:

```console
% git checkout debian
% git merge --no-commit --no-ff release
% dch -v 0.4.0-1
% git add debian/changelog
% git commit
% git buildpackage
```

If the upstream package evolves a lot, one can expect more work to be
necessary.  When packaging for **Ubuntu** and distributing on a PPA,
it is necessary to prepare a source package rather than a binary
package.  For this, we use `git buildpackage -S`.

Once packages are ready, we can *dput* them on the appropriate
servers.

  [anvil]:                       https://github.com/michipili/anvil
  [debian-git]:                  https://wiki.debian.org/PackagingWithGit#Using_the_upstream_repo
  [debian-maintainer-chap2]:     https://www.debian.org/doc/manuals/maint-guide/first.en.html#dh-make
  [debian-maintainer-changelog]: https://www.debian.org/doc/manuals/maint-guide/dreq.en.html#changelog
  [debian-maintainer-control]:   https://www.debian.org/doc/manuals/maint-guide/dreq.en.html#control
  [debian-maintainer-copyright]: https://www.debian.org/doc/manuals/maint-guide/dreq.en.html#copyright
  [debian-maintainer]:           https://www.debian.org/doc/manuals/maint-guide/index.en.html
  [debian-man-dh-make]:          http://manpages.debian.org/cgi-bin/man.cgi?query=dh_make
