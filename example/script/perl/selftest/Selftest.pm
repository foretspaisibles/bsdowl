### Selftest.pm -- Test for our own presence

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2015 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

package Selftest;

use strict;
use warnings;

BEGIN {
    require Exporter;

    # set the version for version checking
    our $VERSION     = 1.00;

    # Inherit from Exporter to export functions and variables
    our @ISA         = qw(Exporter);

    # Functions and variables which are exported by default
    our @EXPORT      = qw(selftest);

    # Functions and variables which can be optionally exported
    our @EXPORT_OK   = qw();
}

sub selftest {
    exit 0;
}

return 1;

### End of file `Selftest.pm'
