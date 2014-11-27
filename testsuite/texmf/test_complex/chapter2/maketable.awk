### maketable.awk -- Prepare the poultry table

# Author: Michael Grünewald
# Date: Sun Nov 23 22:36:46 CET 2014

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
