%%% texlabel.mp -- An illustration with TeX labels

% Author: Michael Grünewald
% Date: Wed Dec  3 07:58:42 CET 2014

% BSD Owl Scripts (https://github.com/michipili/bsdowl)
% This file is part of BSD Owl Scripts
%
% Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
%
% This file must be used under the terms of the BSD license.
% This source file is licensed as described in the file LICENSE, which
% you should have received as part of this distribution.

beginfig(1)
  u := 4cm;
  draw ((0,0) -- (0,u) -- (u,u) -- (u,0) -- cycle)
    rotated 45;
  dotlabel.top(btex $O$ etex, (0,0));
endfig;
bye;

%%% End of file `texlabel.mp'
