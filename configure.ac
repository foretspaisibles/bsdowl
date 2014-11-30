dnl Process this file with autoconf to produce a configure script.
AC_INIT(bps/Makefile)
version='3.0-pre'
AC_CONFIG_AUX_DIR([Library/Autoconf])
AC_CANONICAL_HOST
AC_PROG_AWK()
AC_PROG_GREP()
AC_PROG_INSTALL()
AC_PROG_LN_S()
AC_PROG_MKDIR_P()
AC_PROG_SED()
AC_PROG_ID()
AC_SYSTEM_USER()

#
# Feature control for package managers
#

# Our package can be installed and used even without the following
# programs, nevertheless, it might be useful for packagers and porters
# to let the configure script fail if some programs are not present.

AC_ARG_ENABLE([gpg],
[  --enable-gpg            enable signing of distribution files with GPG],
[AC_NEED_PROG([GPG], [gpg])])

AC_ARG_ENABLE([gm],
[  --enable-gm             enable conversion of METAPOST pictures to raster
                          formats with GraphicsMagick],
[AC_NEED_PROG([GraphicsMagick], [gm])])

AC_ARG_ENABLE([ocaml],
[  --enable-ocaml          enable preparation of OCaml projects],
[AC_NEED_PROG([ocamlc], [ocamlc])])

AC_ARG_ENABLE([findlib],
[  --enable-findlib        enable use of OCaml findlib],
[AC_NEED_PROG([ocamlfind], [ocamlfind])])

AC_TAR_COMPRESSION_METHODS([COMPRESS])
AC_NEED_BSDMAKE()
AC_SUBST([version])
AC_CONFIG_FILES([Makefile.inc bps/bps.bpsconfig.mk])
AC_OUTPUT
