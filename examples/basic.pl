use 5.010;
use strict;
use Data::Dumper;

{
	package Person;
	use Moose;
	has name     => (is => 'rw', isa => 'Str');
	has employer => (is => 'rw', isa => 'Str');
}

use MooseX::Prototype qw(use_as_prototype);
my $CivilServant = use_as_prototype( Person->new(employer => 'HMG') );

my $bob = $CivilServant->new(name => 'Bob');
print Dumper $bob;
