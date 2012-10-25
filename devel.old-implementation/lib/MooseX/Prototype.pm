package MooseX::Prototype;

use 5.010;
use strict;
use utf8;

BEGIN {
	$MooseX::Prototype::AUTHORITY = 'cpan:TOBYINK';
	$MooseX::Prototype::VERSION   = '0.001';
}

use Sub::Exporter -setup => {
	exports => [qw(use_as_prototype)],
};

my $cloned_attributes = sub
{
	my ($instance) = @_;
	
	my @attrs = map
	{
		my $attr = $_;
		if ($attr->has_value($instance))
		{
			my $value = $attr->get_value($instance);
			$attr->clone(default => sub { $value });
		}
		else
		{
			$attr->clone;
		}
	}
	$instance->meta->get_all_attributes;
	
	return @attrs;
};

sub use_as_prototype
{
	my ($instance, $class) = @_;
	
	state $serial = 1;
	$class //= join q{::}, 'MooseX::Prototype::__ANON__', sprintf q{%04d}, $serial++;
	
	Moose::Meta::Class->create(
		$class,
		version        => $instance->meta->version,
		authority      => $instance->meta->authority,
		superclasses   => [ ref $instance ],
		attributes     => [ $instance->$cloned_attributes ],
		);
	
	return $class;
}

__PACKAGE__
__END__

=head1 NAME

MooseX::Prototype - use an existing object as the template for a class

=head1 SYNOPSIS

 {
   package Person;
   use Moose;
   has name     => (is => 'rw', isa => 'Str');
   has employer => (is => 'rw', isa => 'Str');
 }
 
 package main;
 
 use MooseX::Prototype qw(use_as_prototype);
 
 my $template     = Person->new(employer => 'Government');
 my $CivilServant = use_as_prototype($template);
 
 my $bob = $CivilServant->new(name => 'Bob');
 say $bob->name;       # Bob
 say $bob->employer;   # Government

=head1 DESCRIPTION

=head2 C<< use_as_prototype($object) >>

Given a blessed object (must be from a Moose-based class), the
C<use_as_prototype> function generates a new class such that:

=over

=item * the new class is a subclass of the class the original
object was blessed into.

=item * all methods available on the original object will be
available to instances of the new class.

=item * all attributes available on the original object will be
available to instances of the new class, and the defaults for
those attributes will reflect the values those attributes had on
the original object.

=back

In short, it acts like a C<clone> method might, but rather than
returning a single cloned object, returns a class of clones.

The class name used is not necessarily very nice - it will be
along the lines of C<< MooseX::Prototype::__ANON__::0007 >>.
You can provide your own class name as a second parameter:

 my $template = Person->new(employer => 'Government');
 use_as_prototype($template, 'CivilServant');
 
 my $bob = CivilServant->new(name => 'Bob');

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=MooseX-Prototype>.

=head1 SEE ALSO

L<Object::Prototype>, L<MooseX::Prototype::Role::UseAsPrototype>.

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

