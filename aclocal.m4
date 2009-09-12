# -*- autoconf -*-

# AC_PROG_ID
# ----------
# Check for a id program that understands -g -u and -n options. This is not he
# case of Solaris /usr/bin/id which is the first found on the path in some
# configurations.
AC_DEFUN([AC_PROG_ID],
[AC_CACHE_CHECK([for id that handles -g, -u and -n], ac_cv_path_ID,
  [ac_cv_path_ID=no
for ac_cv_path_ID_v in id /usr/xpg4/bin/id 'command -p id'; do
    if test "$ac_cv_path_ID" = "no"; then
      ( $ac_cv_path_ID_v -g && $ac_cv_path_ID_v -g -n && $ac_cv_path_ID_v -u && $ac_cv_path_ID_v -u -n ) 2>&- 1>&- && ac_cv_path_ID="$ac_cv_path_ID_v"
    fi
done;])
ID="$ac_cv_path_ID"
AC_SUBST([ID])
])
