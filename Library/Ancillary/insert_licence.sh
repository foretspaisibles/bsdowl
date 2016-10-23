### insert_licence.sh

# Author: Michael Grünewald
# Date: Thu Mar 13 23:01:35 CET 2008

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

find ../../ -name '*.mk' | while read item; do
    printf 'Modifiying %s\n' $item
    ex $item < insert_licence.ed
done

### End of file `insert_licence.sh'
