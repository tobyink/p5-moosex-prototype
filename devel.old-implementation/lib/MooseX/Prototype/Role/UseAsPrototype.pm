package MooseX::Prototype::Role::UseAsPrototype;

use 5.010;
use strict;
use utf8;

BEGIN {
	$MooseX::Prototype::Role::UseAsPrototype::AUTHORITY = 'cpan:TOBYINK';
	$MooseX::Prototype::Role::UseAsPrototype::VERSION   = '0.001';
}

use Moose::Role;
use MooseX::Prototype use_as_prototype => {-as => '___uap' };

sub use_as_prototype
{
	goto \&___uap;
}

__PACKAGE__
__END__

=head1 NAME

MooseX::Prototype::Role::UseAsPrototype - role providing a use_as_prototype method

=head1 SYNOPSIS

 {
   package Person;
   use Moose;
   with 'MooseX::Prototype::Role::UseAsPrototype';
   has name     => (is => 'rw', isa => 'Str');
   has employer => (is => 'rw', isa => 'Str');
 }
 
 package main;
 
 my $template     = Person->new(employer => 'Government');
 my $CivilServant = $template->use_as_prototype;
 
 my $bob = $CivilServant->new(name => 'Bob');
 say $bob->name;       # Bob
 say $bob->employer;   # Government

=head1 DESCRIPTION

=head2 C<< $object->use_as_prototype >>

Works as per the function of the same name in L<MooseX::Prototype>,
but should be called as a method.

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=MooseX-Prototype>.

=head1 SEE ALSO

L<Object::Prototype>, L<MooseX::Prototype>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2012 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

