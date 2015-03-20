# translate_date.sed -- Translate timestamps from French to C locale

# Author: Michael Grünewald
# Date: Tue Dec  2 19:28:47 CET 2014

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

/^. Date: /{
# Translate French day names to english
s/[Ll]un/Mon/
s/[Mm]ar/Tue/
s/[Mm]er/Wed/
s/[Jj]eu/Thu/
s/[Vv]en/Fri/
s/[Ss]am/Sat/
s/[Dd]im/Sun/

# Translate french mont names to english
s/[Jj]an/Jan/
s/[Ff]év/Feb/
s/[Mm]ar/Mar/
s/[Mm]ai/Mai/
s/[Aa]vr/Apr/
s/[Jj]ui/Jun/
s/[Jj]ul/Jul/
s/[Aa]oû/Aug/
s/[Ss]ep/Sep/
s/[Oo]ct/Oct/
s/[Nn]ov/Nov/
s/[Dd]éc/Dec/

# Reorder Dayname, Month, Day
s/\([A-Z][a-z][a-z]\) \([ 123][0-9]\) \([A-Z][a-z][a-z]\)/\1 \3 \2/

# Tue in second position is actually Mar which was understood as
# Mardi, we translate it back to Mar.

s/\([A-Z][a-z][a-z]\) Tue/\1 Mar/

# Put the year at the end
s/ \([0-9][0-9][0-9][0-9]\)\(.*\)/\2 \1/
}

### End of file `translate_date.sed'
