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
