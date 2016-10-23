### Selftest.pm -- Test for our own presence

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

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
