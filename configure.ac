dnl Process this file with autoconf to produce a configure script.
AC_INIT(bps/Makefile)
AC_SUBST([version], [3.0.0-current])
AC_CONFIG_AUX_DIR([Library/Autoconf])
AC_CANONICAL_HOST
AC_NEED_BSDMAKE()
AC_PROG_AWK()
AC_PROG_GREP()
AC_PROG_INSTALL()
AC_PROG_LN_S()
AC_PROG_MKDIR_P()
AC_PROG_SED()
AC_PROG_ID()
AC_SYSTEM_USER()
AC_TAR_COMPRESSION_METHODS([COMPRESS])

#
# Feature control for package managers
#

# Our package can be installed and used even without the following
# programs, nevertheless, it might be useful for packagers and porters
# to let the configure script fail if some programs are not present.

AC_ARG_WITH([gpg],
  [AS_HELP_STRING([--with-gpg],
    [support signing of distribution files with GPG])],
  [AC_NEED_PROG([GPG], [gpg])])

AC_ARG_WITH([gm],
  [AS_HELP_STRING([--with-gm],
    [support conversion of METAPOST pictures to PNG with GraphicsMagick])],
  [AC_NEED_PROG([GraphicsMagick], [gm])])

AC_ARG_WITH([ocaml],
  [AS_HELP_STRING([--with-ocaml],
    [support preparation of OCaml projects])],
  [AC_NEED_PROG([ocamlc], [ocamlc])])

AC_ARG_WITH([findlib],
  [AS_HELP_STRING([--with-findlib],
    [support use of OCaml findlib in OCaml projects])],
  [AC_NEED_PROG([ocamlfind], [ocamlfind])])

AC_ARG_WITH([tidy],
  [AS_HELP_STRING([--with-tidy],
    [support use of tidy to canonise HTML pages])],
  [AC_NEED_PROG([tidy], [tidy])])

AC_ARG_WITH([opensp],
  [AS_HELP_STRING([--with-opensp],
    [support static HTML pages generation with OpenSP])],
  [AC_NEED_PROG([OpenSP], [onsgmls])])

AC_ARG_WITH([credentials],
  [AS_HELP_STRING([--with-credentials],
    [use ARG for credential switch, where ARG is one of su, sudo or no])],
  [case $with_credentials in
    no|su|sudo)
        SWITCH_CREDENTIALS_STRATEGY=$with_credentials
        ;;
    yes)
        SWITCH_CREDENTIALS_STRATEGY=su
        ;;
    *)
        AC_MSG_ERROR([*** $with_credentials: invalid argument for credentials.])
        ;;
    esac;],
  [case $host_os in
    *cygwin*)
        SWITCH_CREDENTIALS_STRATEGY=no
        ;;
    *)
        SWITCH_CREDENTIALS_STRATEGY=su
        ;;
    esac;])


#
# Conditionally enable tests
#

# OCaml findlib.
#
#   OCaml findlib seems not to be available under Cygwin.  We
#   therefore disable tests requiring it under this platform.

AC_ARG_ENABLE([test-findlib],
  [AS_HELP_STRING([--enable-test-findlib],
    [enable testsuite part requiring findlib])],
  [WITH_TESTSUITE_FINDLIB=${enable_test_findlib}],
  [case $host_os in
    *cygwin*)
        WITH_TESTSUITE_FINDLIB=no
        ;;
    *)
        WITH_TESTSUITE_FINDLIB=yes
        ;;
    esac;])


# Python setup tools
#
#   Support of Python setup tools for preparing Python libraries is an
#   experimental feature.  Corresponding files are always installed
#   but the tests must be explicitly enabled to run.

AC_ARG_ENABLE([test-py-setuptools],
  [AS_HELP_STRING([--enable-test-py-setuptool],
    [enable testsuite part requiring Python setuptools])],
  [WITH_TESTSUITE_PY_SETUPTOOLS=${enable_test_py_setuptool}],
  [WITH_TESTSUITE_PY_SETUPTOOLS=no])


AC_SUBST([SWITCH_CREDENTIALS_STRATEGY])
AC_SUBST([WITH_TESTSUITE_FINDLIB])
AC_SUBST([WITH_TESTSUITE_PY_SETUPTOOLS])
AC_CONFIG_FILES([Makefile.inc bps/bps.bpsconfig.mk testsuite/Makefile.inc])
AC_OUTPUT
