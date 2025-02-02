package DBD::Oracle::Object;
{
  $DBD::Oracle::Object::VERSION = '1.50';
}
BEGIN {
  $DBD::Oracle::Object::AUTHORITY = 'cpan:PYTHIAN';
}
# ABSTRACT: Wrapper for Oracle objects

use strict;
use warnings;

sub type_name {  shift->{type_name}  }

sub attributes {  @{shift->{attributes}}  }

sub attr_hash {
	my $self = shift;
	return $self->{attr_hash} ||= { $self->attributes };
}

sub attr {
	my $self = shift;
	if (@_) {
		my $key = shift;
		return $self->attr_hash->{$key};
	}
	return $self->attr_hash;
}

1;

__END__
=pod

=head1 NAME

DBD::Oracle::Object - Wrapper for Oracle objects

=head1 VERSION

version 1.50

=head1 AUTHORS

=over 4

=item *

Tim Bunce <timb@cpan.org>

=item *

John Scoles

=item *

Yanick Champoux <yanick@cpan.org>

=item *

Martin J. Evans <mjevans@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 1994 by Tim Bunce.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

