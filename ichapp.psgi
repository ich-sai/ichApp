use strict;
use warnings;

use ichApp;

my $app = ichApp->apply_default_middlewares(ichApp->psgi_app);
$app;

