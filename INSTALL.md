# Installation

## Requirements

BSD Owl Scripts works at least in the following
versions of the **make** program:

 - FreeBSD 9.0 and newer with he base system program `make`;
 - Mac OS X 10.4 and newer with the third-party program `bmake`;
 - Debian 7.0 and newer with the third-party program `bmake`.

Some special features require extra software being installed on the
system where BSD Owl Scripts is used.  This is advertised in
the corresponding documentation.


*How to install a compatible version of make on FreeBSD?*
On FreeBSD, the version of **make** provided in the base system can be
used and no additional package is required.

*How to install a compatible version of make on Mac OS X or Linux?*
On Mac OS X or Linux, the adequate version of the **make** program is
usually packaged as **bmake** and can readily be installed using
MacPorts on Mac OS X or **aptitude** on Debian.  If a package is not
available for your distribution, this is not a problem for **bmake**
is very portable and [easy to install][install-bmake].

*Other dependencies*
Depending on the exact set of features we want to use, we may need to
install the following software packages: graphicsmagick, awk, m4,
ocaml, texlive-latex-base, gnupg, ocaml-findlib, opensp.  Their exact
name can very from packaging system to packaging system.


## Site-wide installation procedure

First of all, acquire the latest tarball `bsdowl-3.0.0-20150314.tar.xz`
and its signature `bsdowl-3.0.0-20150314.tar.xz.sig` that you should
verify—alternatively, download the tip of the
[development branch][branch/master] or of the
[release branch][branch/release].
Point a root shell to the directory containing the tarball:

```console
# tar xJf bsdowl-3.0.0-20150314.tar.xz
# cd bsdowl-3.0.0-20150314
```

You now have to choose an installation prefix, say `/usr/local`, where
the directives and a few helper scripts are installed:

```console
# ./configure --prefix=/usr/local
# make -r all
# make -r install
```

To let BSD Make know about bsdowl, you then need to
ensure that `/usr/local/bin` is listed in the path for each system
user and that `/usr/local/share/mk` is listed in the search path
for your compatible make program, this is usually done by adding the
line

```makefile
.MAKEFLAGS: -I /usr/local/share/mk
```

To the file `/etc/make.conf`.


## User-specific installation procedure

First of all, acquire the latest tarball `bsdowl-3.0.0-20150314.tar.xz`
and its signature `bsdowl-3.0.0-20150314.tar.xz.sig` that you should
verify—alternatively, download the tip of the
[development branch][branch/master] or of the
[release branch][branch/release].
Point a user shell to the directory containing the tarball:

```console
% tar xJf bsdowl-3.0.0-20150314.tar.xz
% cd bsdowl-3.0.0-20150314
% ./configure --prefix=${HOME}
% env MAKEFLAGS= make -r all
% env MAKEFLAGS= make -r install
```

To let BSD Make know about bsdowl, you then need to
ensure that `${HOME}/bin` is listed in your path and that the
`MAKEFLAGS` variable contains `-I ${HOME}/share/mk`.  If you
are using `bash` or `sh` you can achieve this by appending the lines

```sh
PATH="${HOME}/bin:${PATH}"
MAKEFLAGS="${MAKEFLAGS}${MAKEFLAGS:+ }-I ${HOME}/share/mk"
export PATH
export MAKEFLAGS
```

to your `~/.profile` or `~/.bashrc` file, depending on your
configuration.  If you are using **tcsh** you can achieve this by
appending the following lines

```tcsh
set -f path = ( $path $HOME/bin )

if ( $?MAKEFLAGS ) then
    set makeflags = ( $MAKEFLAGS )
else
    set makeflags = ()
endif

set makeflags = ( $makeflags "-I ${HOME}/share/mk" )
setenv MAKEFLAGS   "$makeflags"
unset makeflags
```

to your `~/.cshrc` or `~/.tcshrc`, depending on your configuration.
These two suggestions will work in typical cases but some special
configuration will require arrangements.


  [install-bmake]:      INSTALL.bmake.md
  [branch/master]:      https://github.com/michipili/bsdowl/tree/master
  [branch/release]:     https://github.com/michipili/bsdowl/tree/release
