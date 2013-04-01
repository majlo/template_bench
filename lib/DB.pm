package DB;

use strict;
use ORLite {
    file => 'db/templatebench.db',
    package => 'DB',
};

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    $self->do("PRAGMA foreign_keys = ON");
    return $self;
}

1;
