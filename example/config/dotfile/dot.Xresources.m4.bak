!!! dot.Xresources -- Resources dor X clients

! Author: Michael Grünewald
! Date: Sun Nov 23 15:52:11 CET 2014

! BSD Owl Scripts (https://github.com/michipili/bsdowl)
! This file is part of BSD Owl Scripts
!
! Copyright © 2002–2016 Michael Grünewald
!
! This file must be used under the terms of the CeCILL-B.
! This source file is licensed as described in the file COPYING, which
! you should have received as part of this distribution. The terms
! are also available at
! http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt
dnl
dnl Color and faces
define(`BGCOLOR', `#E5E5F7')dnl
define(`FACE_FIXED_NAME', `Monospace')dnl
define(`FACE_FIXED', `FACE_FIXED_NAME-$1')dnl
define(`FACE_FIXED_NORMAL', `FACE_FIXED(11)')dnl
define(`FACE_FIXED_LARGE', `FACE_FIXED(17)')dnl
define(`FONT_FIXED', `-adobe-courier-medium-r-*-*-*-$1-100-100-*-*-$2')dnl

!!! Terminal X

! It seems that the vt100.faceName entry seems to override the values
! assigned to vt100.font and vt100.utf8fonts.font.

xterm.vt100.geometry: 80x24
xterm.vt100.font: FONT_FIXED(`110', `Latin9')
xterm.vt100.utf8fonts.font: FONT_FIXED(`110', `UTF8')
xterm.vt100.faceName: FACE_FIXED_NAME
xterm.vt100.faceSize: 12
xterm.*.font: FONT_FIXED(`110', `Latin9')
xterm.*.background: BGCOLOR

!!! Ressources for Emacs

emacs.font: FACE_FIXED_NORMAL
emacs.geometry: 80x40
emacs.lineSpacing: 4
emacs.cursorBlink: off
emacs.cursorColor: chocolate
emacs.verticalScrollBars: off
emacs.background: BGCOLOR

!!! End of file `dot.Xresources'
