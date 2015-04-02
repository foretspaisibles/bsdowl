# Notes for developing BSD Owl Scripts

A nice feature of **BSD Owl Scripts** is its *developer subshell*. At
the root directory of any package which is developed with **BSD Owl
Scripts** the special command

```console
% make subshell
```

starts a *developer subshell*, it is a shell whose environment has
been adjusted so that **BSD Make** and **BSD Owl Scripts** still can
find the root directory of the package, its configuration, specific
Makefiles and a lot of other files.

This subshell is handy to work on a single module of the package.  It
is also customary to open several developer subshells, one visiting a
module and another visiting the corresponding tests.

Taking advantage of the developer subshell functionality requires to
work in a sanitised environment. It is mandatory that your
`~/.profile` or your `~/.cshrc` do not *prepend* the path to a **BSD
Owl Script** installation to *MAKEFLAGS*. So, for instance, the Bourne
profile snippet

```sh
MAKEFLAGS="${MAKEFLAGS}${MAKEFLAGS:+ }-I ${HOME}/share/mk"
export MAKEFLAGS
```

is safe, even if you installed **BSD Owl Scripts** in
`${HOME}/share/mk`, but the snippet

```sh
MAKEFLAGS="-I ${HOME}/share/mk${MAKEFLAGS:+ }${MAKEFLAGS}"
export MAKEFLAGS
```

is not safe, because **BSD Owl Scripts** files in `${HOME}/share/mk`
will shadow those in your working copy.
