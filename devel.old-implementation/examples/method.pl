use 5.010;
use strict;
use Data::Dumper;

{
	package Person;
	use Moose;
	with 'MooseX::Prototype::Role::UseAsPrototype';
	has name     => (is => 'rw', isa => 'Str');
	has employer => (is => 'rw', isa => 'Str');
}

Person->new(employer => 'HMG')->use_as_prototype('CivilServant');

my $bob = CivilServant->new(name => 'Bob');
print Dumper $bob;
