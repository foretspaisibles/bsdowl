# Configuration files

As a UNIX user you are likely to have several configuration files for
your applications.  As these files are commonly stored under your home
directory and prefixed with a dot, let us call them *dotfiles*. If you
consider using a [RCS](http://en.wikipedia.org/wiki/RCS) to keep track
of the revisions you do to your files you will also need an
installation procedure.  This procedure is provided by BSD Make Pallàs
Scripts.

This setting is also very useful in you want to use the same
configuration files on different systems.


## Using GIT and BSD Owl Scripts

Use the following procedure to get started managing the revisions of
your files with `git`.

**Step 1.** Create a directory `dotfiles`.

```console
% mkdir dotfiles
```

**Step 2.** Intitalise this directory as a git repository.

```console
% cd dotfiles
% git init
```

**Step 3.** Copy your dotfiles there, `~/.profile` as `dot.profile`
and so on.

```console
% cp ~/.profile dot.profile
% cp ~/.emacs dot.emacs
```

**Step 4.** Create a `Makefile` as explained in the documentation of
`conf.dotfile.mk`.

```makefile
### Makefile -- dotfiles

DOTFILE=	dot.profile
DOTFILE+=	dot.emacs

.include "misc.dotfile.mk"
```

**Step 5.** Register your files and commit them.

```console
% git add dot.* Makefile
% git commit -m "Import my dotfiles"
```

**Step 6.** Edit your files and register your changes in git.

**Step 7.** Install your files with `make install`.﻿

**Step 8.** Repeat steps 6 and 7 as needed.

Note that on your system, you may have to use another `make` program,
such as `pmake` under Debian or `bsdmake` under Mac OS X, as detailed
in the [installation procedure](../INSTALL.md).
