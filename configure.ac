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
SYSTEMOWN=root
SYSTEMGRP=$($ID -gn $SYSTEMOWN)

AC_NEED_PROG([GPG], [gpg])
AC_SUBST([GPG], [gpg])
AC_NEED_PROG([GraphicsMagick], [gm])
#
# Determine compression tools
#
define([CHECK_TAR_OPTION], [dnl
printf 'checking whether tar -$1 works... '
if tar c$1f /dev/null /dev/null >/dev/null 2>&1; then
	$2=yes
else
	$2=no
fi
printf '%s\n' "$$2"])dnl
CHECK_TAR_OPTION(z, USE_GZIP)
CHECK_TAR_OPTION(j, USE_BZIP2)
CHECK_TAR_OPTION(J, USE_XZ)
if test "${USE_XZ}" = "yes"; then
	USE_BZIP2="no"
fi
COMPRESS=""
if test "${USE_GZIP}" = "yes"; then
	COMPRESS="${COMPRESS}${COMPRESS:+ }gzip"
fi
if test "${USE_BZIP2}" = "yes"; then
	COMPRESS="${COMPRESS}${COMPRESS:+ }bzip2"
fi
if test "${USE_XZ}" = "yes"; then
	COMPRESS="${COMPRESS}${COMPRESS:+ }xz"
fi
AC_NEED_BSDMAKE()
AC_SUBST([version])
AC_SUBST([COMPRESS])
AC_SUBST([SYSTEMOWN])
AC_SUBST([SYSTEMGRP])
AC_OUTPUT(Makefile.inc)
AC_OUTPUT(bps/bps.bpsconfig.mk)
