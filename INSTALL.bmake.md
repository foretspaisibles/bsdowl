# Installation of BMake

If you are working in hostile wilderness and do not have access to an
appropriately packaged compatible **make** program, you may try the
**bmake** program found at crufty's.

Let us review together the installation procedure.


## Download

We downlad the files `bmake.tar.gz` and `mk.tar.gz` distributed by
their author:

    http://void.crufty.net/ftp/pub/sjg/bmake.tar.gz
    http://void.crufty.net/ftp/pub/sjg/mk.tar.gz

In the sequel, we assume that the tarballs were downloaded to
`~/distfiles`.


## Explode

Point your shell to a working directory and explode the tarballs with

```console
% tar xzf ~/distfiles/bmake.tar.gz
% tar xzfC ~/distfiles/mk.tar.gz bmake
```

## Build and install

The tarballs are shipped with a _build and install_ script, that will
use `/usr/local` as installation prefix.

```console
% ./bmake/boot-strap --prefix=/usr/local --install
```

It is possible to change this prefix, as in

```console
% ./bmake/boot-strap --prefix=${HOME} --install
```

If the command completes succesfully, the `bmake` program is then
installed under the given prefix *PREFIX* and the standard macros
shipped with the program are in `${PREFIX}/share/mk`.  If appropriate,
use the same installation prefix for BSD Owl Scripts when you
later install them.


## Portability

The portability of **bmake** is excellent, I only experienced problems
while trying to build it with an obsolete GCC on Solaris 10.  Versions
of GCC newer as 3.6 seem to build **bmake** without error.
