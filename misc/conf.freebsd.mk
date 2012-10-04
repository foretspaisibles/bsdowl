### conf.freebsd.mk -- Installation of configuration files for FreeBSD

# Author: Michaël Le Barbier Grünewald
# Date: Sam  3 oct 2009 18:25:04 CEST
# Lang: fr_FR.ISO8859-15

# $Id$

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) Michaël Le Barbier Grünewald - 2009
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

# This module defines several FILESGROUPS that can be used to install
# configuration files on FreeBSD systems.
#
# These files groups are:
#
#  BASE		For base system configuration files, in /etc
#  PORT		For port configuration files, in ${LOCALBASE}/etc
#  KERN		For kernel configuration files
#  BOOT		For boot configuration files, in /boot
#  CSUP		For csup configuration files, in /etc/csup
#  FDI		For device file informations used by HAL
#  RC		For RC files used to boot the system
#  KDE		For KDE configuration files
#  XDM		For XDM configuration files, in ${LOCALBASE}/lib/X11/xdm
#  XDMPIXMAP	For XDM pixmaps
#  XFCE		For XFCE configuration files

PREFIX?=
LOCALBASE?= /usr/local


# BASE
#
#  Base system configuration files
#
#  Such as rc.conf, hosts, networks, groups, etc.

FILESGROUPS+= BASE

BASEDIR?= /etc
BASEOWN?= root
BASEGRP?= wheel
BASEMODE?= 444
BASEDIR.sshd_config = ${BASEDIR}/ssh
BASEDIR.ssh_config = ${BASEDIR}/ssh
BASEMODE.hostpad.conf = 400


# RC
#
#  Setting up services at boot time

FILESGROUPS+= RC

RCDIR?= ${LOCALBASE}/etc/rc.d
RCOWN?= ${BASEOWN}
RCGRP?= ${BASEGRP}
RCMODE?= 555

.if defined(RC)&&!empty(RC)
.if ${RC} == "f77"
RC:=
.endif
.endif


# PORT
#
#  Third party packages configurations files
#
#  Such as sudoers, pkgtools.conf, apache configuration files, etc.

FILESGROUPS+= PORT

PORTDIR?= ${LOCALBASE}/etc
PORTOWN?= ${BASEOWN}
PORTGRP?= ${BASEGRP}
PORTMODE?= 444

PORTMODE.sudoers = 440
PORTDIR.PolicyKit.conf = ${PORTDIR}/PolicyKit
PORTDIR.fonts-local.conf = ${PORTDIR}/fonts
PORTNAME.fonts-local.conf = local.conf

# FDI
#
#  Device information files for the HAL system

FILESGROUPS+= FDI

FDIDIR?= ${LOCALBASE}/share/hal/fdi/preprobe/20thirdparty
FDIOWN?= ${BASEOWN}
FDIGRP?= ${BASEGRP}
FDIMODE?= 444


# KERN
#
#  Kernel configuration files
#
#  The machine is guessed from the MACHINE variable.  Note: it would
#  be nice to define a group for each supported machine type, so that
#  kernels for various machines can be prepared.

FILESGROUPS+= KERN

KERNDIR?= /usr/src/sys/${MACHINE}/conf
KERNOWN?= ${BASEOWN}
KERNGRP?= ${BASEGRP}
KERNMODE?= 444


# BOOT
#
#  Loader configuration files
#
#  These files usually go under /boot.

FILESGROUPS+= BOOT

BOOTDIR?= /boot
BOOTOWN?= ${BASEOWN}
BOOTGRP?= ${BASEGRP}
BOOTMODE?= 444


# CSUP
#
#  CVS Update
#
#  Csup is a software package for updating collections of files
#  across a network. It is used to keep FreeBSD sources and the ports
#  collection in sync. Its configuration files goes under /etc/csup.

FILESGROUPS+= CSUP

CSUPDIR?= /etc/csup
CSUPOWN?= ${BASEOWN}
CSUPGRP?= ${BASEGRP}
CSUPMODE?= 444

CSUPDIR.refuse-supfile =/var/db/sup
CSUPNAME.refuse-supfile = refuse


# XORG
#
#  X server configuration files
#
#  Theses files go under /etc/X11.  Note that these files must be read
#  somewhere to be effective, for instance in the Xsession script.

FILESGROUPS+= XORG

XORGDIR?= /etc/X11
XORGOWN?= ${BASEOWN}
XORGGRP?= ${BASEGRP}
XORGMODE?= 444


# KDE
#
#  K Desktop Environment
#
#  KDE is a desktop environment.  Among other bits of software, it
#  provides a display manager daemon, that is a system component.  We
#  handle KDE4.

FILESGROUPS+= KDE

KDEDIR?= ${LOCALBASE}/kde4/share/config
KDEOWN?= ${BASEOWN}
KDEGRP?= ${BASEGRP}
KDEMODE?= 444

KDEDIR.kdmrc = ${KDEDIR}/kdm


# XDM
#
#  X Display Manager
#
#  XDM is the display manager daemon shipped with Xorg. It is highly
#  configurable, see comments in the relevant files.

FILESGROUPS+= XDM
XDMDIR?= ${LOCALBASE}/lib/X11/xdm
XDMOWN?= ${BASEOWN}
XDMGRP?= ${BASEGRP}
XDMMODE?= 444

XDMMODE.GiveConsole?= 555
XDMMODE.TakeConsole?= 555
XDMMODE.Xreset?= 555
XDMMODE.Xsession?= 555
XDMMODE.Xstartup?= 555
XDMMODE.Xwilling?= 555

.for file in ${XDM:MXsetup_*}
XDMMODE.${file:T}?= 555
.endfor

FILESGROUPS+= XDMPIXMAP
XDMPIXMAPDIR?= ${LOCALBASE}/lib/X11/xdm/pixmaps
XDMPIXMAPOWN?= ${BASEOWN}
XDMPIXMAPGRP?= ${BASEGRP}
XDMPIXMAPMODE?= 444



# Images goes under ${XDMDIR}/pixmaps
.for suffix in png gif jpg jpeg xpm
.for file in ${XDM:M*.${suffix}}
XDMDIR.${file:T}?= ${XDMDIR}/pixmaps
.endfor
.endfor


#
# Epilogue
#

USE_SWITCH_CREDENTIALS = yes

.include "bps.init.mk"
.include "bps.credentials.mk"
.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `conf.freebsd.mk'
