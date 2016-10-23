### maketable.awk -- Prepare the poultry table

# Author: Michael Grünewald
# Date: Sun Nov 23 22:36:46 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

BEGIN {
    FS="|"
}

NR <= 2 {
    printf("\\textsl{%s}&\\textsl{%s}&\\textsl{%s}&\\textsl{%s}&\\textsl{%s}\\\\", $1, $2, $3, $4, $5);
}

NR > 2 {
    printf("\\textbf{%s}&%s&%s&%s&%s\\\\\n", $1, $2, $3, $4, $5);
}

### End of file `maketable.awk'
