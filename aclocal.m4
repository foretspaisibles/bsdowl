# -*- autoconf -*-

# Author: Michael Grünewald
# Date: Sat Sep 12 13:02:08 CEST 2009

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

m4_include([Library/Autoconf/ocaml.m4])


# AC_PROG_ID
# ----------
# Check for a id program that understands -g -u and -n options. This is not the
# case of Solaris' /usr/bin/id which is the first found on the path in some
# configurations.
#
# If a suitable program is found, it can be used through the content
# of the ID program.  If no such a program is found, the value of this
# variable is `no`.
AC_DEFUN([AC_PROG_ID],
[AC_CACHE_CHECK([for id that handles -g, -u and -n], ac_cv_path_ID,
  [ac_cv_path_ID=no
for ac_cv_path_ID_v in id /usr/xpg4/bin/id 'command -p id'; do
    if test "$ac_cv_path_ID" = "no"; then
      ( $ac_cv_path_ID_v -g && $ac_cv_path_ID_v -g -n && $ac_cv_path_ID_v -u && $ac_cv_path_ID_v -u -n ) 2> /dev/null 1> /dev/null && ac_cv_path_ID="$ac_cv_path_ID_v"
    fi
done;])
ID="$ac_cv_path_ID"
AC_SUBST([ID])
])


# AC_PROG_BSDMAKE
# ---------------
# Check for a BSD Make program which is compatible with a recent
# version of BSD Make (2014-02-14 or later).
#
# - On FreeBSD 10.0 or newer, it will use `make' from the base system.
# - On NetBSD 6.1.5 or newer, it will use `make' from the base system.
# - On other platforms, it will look for a `bmake' program.
#
# If a suitable program is found, its name is affected to the BSDMAKE
# variable.  If no such a program has been found, this variable is set
# to `no'.
#
# Note that OpenBSD is not supported as there is modern no version of
# bmake available wether in the base system nor in the ports at time
# of writing (OpenBSD 5.6).
#
# This macro will break for NetBSD 10.X, many years from now.
AC_DEFUN([AC_PROG_BSDMAKE_BASEBSD],
[case $host_os in
    # FreeBSD 10.0 or newer will match.
    freebsd*)
        ac_cv_path_BSDMAKE_freebsd_version=${host_os#freebsd}
        if test ${ac_cv_path_BSDMAKE_freebsd_version%%.*} -ge 10; then
            ac_cv_path_BSDMAKE=make
        fi
        ;;
    # NetBSD 6.0 or newer will match.
    netbsd*)
        ac_cv_path_BSDMAKE_netbsd_version=${host_os#netbsd}
        if test ${ac_cv_path_BSDMAKE_netbsd_version%%.*} -ge 6; then
            ac_cv_path_BSDMAKE=make
        fi
        ;;
esac])dnl
AC_DEFUN([AC_PROG_BSDMAKE],
[AC_CACHE_CHECK([for a modern BSD Make program], ac_cv_path_BSDMAKE,
  [AC_REQUIRE([AC_CANONICAL_HOST])[]dnl
ac_cv_path_BSDMAKE=no
if test "$ac_cv_path_BSDMAKE" = "no"; then
    AC_PROG_BSDMAKE_BASEBSD
fi
if test "$ac_cv_path_BSDMAKE" = "no"; then
    if ! test "x$(which bmake)" = "x"; then
        ac_cv_path_BSDMAKE=bmake
    fi
fi;])
BSDMAKE="$ac_cv_path_BSDMAKE"
AC_SUBST([BSDMAKE])
])dnl


# AC_CHECK_BSDMAKE([ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
# ----------------------------------------------------------
# Macro for checking if a modern version of BSD make is installed.
AC_DEFUN([AC_CHECK_BSDMAKE],
[AC_REQUIRE([AC_PROG_BSDMAKE])[]dnl
AS_IF([test "$BSDMAKE" = "no"], [$2], [$3])])dnl


# AC_NEED_BSDMAKE
# ---------------
AC_DEFUN([AC_NEED_BSDMAKE],
[AC_CHECK_BSDMAKE([], [AC_MSG_ERROR([*** BSD Make not found.])])])


# AC_HAS_PROG([PROGRAM NAME])
# ---------------------------
AC_DEFUN([AC_HAS_PROG],
  [if test "x$has_$1" = 'x'; then
     AC_CHECK_PROG([has_$1], [$1], [yes], [no])
   fi;])


# AC_NEED_PROG([INFORMAL PROGRAM NAME], [PROGRAM NAME])
# -----------------------------------------------------
AC_DEFUN([AC_NEED_PROG],
[AC_CHECK_PROGS([has_$1], [$2], [yes], [no], [path_$1])
if test "x$has_$2" = 'xno'; then
  AC_MSG_ERROR([*** $1 not found.])
fi;])

# AC_ARG_WITH_PROG([OPTION], [HELP], [INFORMAL PROGRAM NAME], [PROGRAM NAME])
# ---------------------------------------------------------------------------
AC_DEFUN([AC_ARG_WITH_PROG],
  [AC_ARG_WITH([$1], [$2],
    [if test "x$with_$1" = 'xyes'; then
      AC_NEED_PROG([$3], [$4])
     fi])])

# AC_SYSTEM_USER
# --------------
# Fill the variables SYSTEMOWN and SYSTEMGRP with values that can be
# passed as arguments to the -o and -g options of the install program.
#
# These variables are selected for substitution.
#
# On Cygwin we use numeric uids and gids because it is common for
# these names to contain spaces.
#
# Some systems do not have a wheel group, we therefore rely on our
# ID command to determine the group of the root user.
AC_DEFUN([AC_SYSTEM_USER],
  [AC_REQUIRE([AC_CANONICAL_HOST])[]dnl
  AC_REQUIRE([AC_PROG_ID])[]dnl
  case $host_os in
    *cygwin*)
      SYSTEMOWN=$($ID -u)
      SYSTEMGRP=$($ID -g)
      ;;
    *)
      SYSTEMOWN=root
      SYSTEMGRP=$($ID -gn $SYSTEMOWN)
    ;;
  esac
  AC_SUBST([SYSTEMOWN])
  AC_SUBST([SYSTEMGRP])
])


# AC_CHECK_TAR_OPTION([TAR-OPTION], [VARIABLE])
# ---------------------------------------------
# Check if the tar command supports TAR-OPTION and set VARIABLE to yes
# or to no accordingly.
AC_DEFUN([AC_CHECK_TAR_OPTION],
  [printf 'checking whether tar -$1 works... '
if tar c$1f /dev/null /dev/null >/dev/null 2>&1; then
	$2=yes
else
	$2=no
fi
printf '%s\n' "$$2"])dnl


# AC_TAR_COMPRESSION_METHODS([VARIABLE])
# --------------------------------------

# Determine the list of compression methods supported by tar. These
# compression methods are designed by gzip, bzip2 and xz.
#
# The list of available methods is stored in VARIABLE and this
# variable is marker for substitution.
AC_DEFUN([AC_TAR_COMPRESSION_METHODS],
  [AC_CHECK_TAR_OPTION(z, ac_tar_compression_gzip)
   AC_CHECK_TAR_OPTION(j, ac_tar_compression_bzip2)
   AC_CHECK_TAR_OPTION(J, ac_tar_compression_xz)
   $1=""
   AC_TAR_COMPRESSION_PACK([gzip], [$1])
   AC_TAR_COMPRESSION_PACK([bzip2], [$1])
   AC_TAR_COMPRESSION_PACK([xz], [$1])
   AC_SUBST([$1])
])
AC_DEFUN([AC_TAR_COMPRESSION_PACK],
  [if test "${ac_tar_compression_$1}" = "yes"; then
	COMPRESS="${$2}${$2:+ }$1"
fi;])
