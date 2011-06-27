# -*- autoconf -*-

# Author: Michaël Le Barbier Grünewald
# Date: Sam 12 sep 2009 13:02:08 CEST
# Lang: fr_FR.ISO8859-1

# $Id$

# Copyright (c) 2009 Michaël Le Barbier Grünewald
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#    1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#    2. Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#
#    3. The name of the author may not be used to endorse or promote
#    products derived from this software without specific prior written
#    permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
# IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.


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
