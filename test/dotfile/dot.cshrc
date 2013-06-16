### csh.cshrc -- TCSH Resource Configuration Script

# Author: Michael Grünewald
# Date: Ven 26 jan 2007 19:32:47 CET

setenv MAKEFLAGS "-I ${HOME}/share/mk"
#setenv TEXMFCNF "${HOME}/share/texmf/web2c"
set nethack_name=Malchance
set nethack_pickup='$'
setenv NETHACKOPTIONS "autopickup,name:$nethack_name,catname:Jezabeth,\!cmdassist,dogname:Melba,pettype:cat,color,number_pad:1,suppress_alert:2.0.0,pickup_types:$nethack_pickup"

### End of file `csh.cshrc'
