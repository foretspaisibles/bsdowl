# -*- autoconf -*-

# Author: Michael Grünewald
# Date: Sam 12 sep 2009 13:02:08 CEST

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2014 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt


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
