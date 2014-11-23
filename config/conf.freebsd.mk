### conf.freebsd.mk -- Installation of configuration files for FreeBSD

# Author: Michael Grünewald
# Date: Sam Oct  3 2009 18:25:04 CEST

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

# Variables:
#
#
#  LOCALBASE [/usr/local]
#   The prefix used by ports
#
#
#  BASE [not set]
#   Base system configuration files, belonging to /etc
#
#   Such as rc.conf, hosts, networks, groups, etc.
#
#
#  RCD [not set]
#   Script setting up services at boot time
#
#
#  PORT [not set]
#   Third party packages configurations files
#
#   Such as sudoers, pkgtools.conf, apache configuration files, etc.
#
#
#  FDI [not set]
#   Device information files for the HAL system
#
#
#  KERN [not set]
#   Kernel configuration files
#
#   The machine is guessed from the MACHINE variable.  Note: it would
#   be nice to define a group for each supported machine type, so that
#   kernels for various machines can be prepared.
#
#
#  BOOT [not set]
#   Loader configuration files
#
#   These files usually go under /boot.
#
#
#  CSUP [not set, deprecated]
#   CVS Update files
#
#   Csup is a software package for updating collections of files
#   across a network. It is used to keep FreeBSD sources and the ports
#   collection in sync. Its configuration files goes under /etc/csup.
#
#   Not that this update mechanism is deprecated.
#
#
#  XORG
#   X server configuration files
#
#   Theses files go under /etc/X11.  Note that these files must be read
#   somewhere to be effective, for instance in the Xsession script.
#
#
#  KDE
#   Configuration files for the K Desktop Environment
#
#   KDE is a desktop environment.  Among other bits of software, it
#   provides a display manager daemon, that is a system component.  We
#   handle KDE4.
#
#
#  XDM
#   X Display Manager
#
#   XDM is the display manager daemon shipped with Xorg. It is highly
#   configurable, see comments in the relevant files.
#
#
#  JAILDIR [not set]
#   The base directory of the jail where files should be installed


THISMODULE=		conf.freebsd
USE_SWITCH_CREDENTIALS=	yes

LOCALBASE?=		/usr/local


#
# BASE, for base system configuration files, in /etc
#

FILESGROUPS+=		BASE

BASEDIR?=		${JAILDIR}/etc
BASEOWN?=		root
BASEGRP?=		wheel
BASEMODE?=		444
BASEDIR.sshd_config=	${BASEDIR}/ssh
BASEDIR.ssh_config=	${BASEDIR}/ssh
BASEMODE.hostpad.conf=	400

.if !empty(BASE:Mlogin.conf)
post-install: post-install-rebuild-logindb
post-install-rebuild-logindb:
	cap_mkdb /etc/login.conf
.endif


#
#  RCD, for initialisation files used to boot the system
#

FILESGROUPS+=		RCD

RCDDIR?=		${JAILDIR}${LOCALBASE}/etc/rc.d
RCDOWN?=		${BASEOWN}
RCDGRP?=		${BASEGRP}
RCDMODE?=		555


#
#  PORT, for port configuration files, in ${LOCALBASE}/etc
#

FILESGROUPS+=		PORT

PORTDIR?=		${JAILDIR}${LOCALBASE}/etc
PORTOWN?=		${BASEOWN}
PORTGRP?=		${BASEGRP}
PORTMODE?=		444

PORTMODE.sudoers=	440
PORTDIR.PolicyKit.conf=${PORTDIR}/PolicyKit
PORTDIR.fonts-local.conf=${PORTDIR}/fonts
PORTNAME.fonts-local.conf=local.conf


#
# FDI, device information files for the HAL system
#

FILESGROUPS+=		FDI

FDIDIR?=		${JAILDIR}${LOCALBASE}/share/hal/fdi/preprobe/20thirdparty
FDIOWN?=		${BASEOWN}
FDIGRP?=		${BASEGRP}
FDIMODE?=		444


#
# Kernel configuration files
#

FILESGROUPS+=		KERN

KERNDIR?=		${JAILDIR}/usr/src/sys/${MACHINE}/conf
KERNOWN?=		${BASEOWN}
KERNGRP?=		${BASEGRP}
KERNMODE?=		444


#
#  Bootloader configuration files
#

FILESGROUPS+=		BOOT

BOOTDIR?=		${JAILDIR}/boot
BOOTOWN?=		${BASEOWN}
BOOTGRP?=		${BASEGRP}
BOOTMODE?=		444


#
#  CVS Update
#

FILESGROUPS+=		CSUP

CSUPDIR?=		${JAILDIR}/etc/csup
CSUPOWN?=		${BASEOWN}
CSUPGRP?=		${BASEGRP}
CSUPMODE?=		444

CSUPDIR.refuse-supfile=/var/db/sup
CSUPNAME.refuse-supfile=refuse


#
#  X server configuration files
#

FILESGROUPS+=		XORG

XORGDIR?=		${JAILDIR}/etc/X11
XORGOWN?=		${BASEOWN}
XORGGRP?=		${BASEGRP}
XORGMODE?=		444

#
#  K Desktop Environment
#

FILESGROUPS+=		KDE

KDEDIR?=		${JAILDIR}${LOCALBASE}/kde4/share/config
KDEOWN?=		${BASEOWN}
KDEGRP?=		${BASEGRP}
KDEMODE?=		444

KDEDIR.kdmrc=		${KDEDIR}/kdm


#
#  X Display Manager
#

FILESGROUPS+=		XDM
XDMDIR?=		${JAILDIR}${LOCALBASE}/lib/X11/xdm
XDMOWN?=		${BASEOWN}
XDMGRP?=		${BASEGRP}
XDMMODE?=		444

XDMMODE.GiveConsole?=	555
XDMMODE.TakeConsole?=	555
XDMMODE.Xreset?=	555
XDMMODE.Xsession?=	555
XDMMODE.Xstartup?=	555
XDMMODE.Xwilling?=	555

.for file in ${XDM:MXsetup_*}
XDMMODE.${file:T}?=	555
.endfor

# Images goes under ${XDMDIR}/pixmaps
.for suffix in png gif jpg jpeg xpm
.for file in ${XDM:M*.${suffix}}
XDMDIR.${file:T}?= ${XDMDIR}/pixmaps
.endfor
.endfor


.include "bps.init.mk"
.include "bps.credentials.mk"
.include "bps.clean.mk"
.include "bps.files.mk"
.include "bps.usertarget.mk"

### End of file `conf.freebsd.mk'
