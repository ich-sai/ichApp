use utf8;
package Noodles::Schema::Result::CtrlValue;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Noodles::Schema::Result::CtrlValue

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<ctrl_values>

=cut

__PACKAGE__->table("ctrl_values");

=head1 ACCESSORS

=head2 keyword

  data_type: 'text'
  is_nullable: 0

=head2 value

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "keyword",
  { data_type => "text", is_nullable => 0 },
  "value",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</keyword>

=back

=cut

__PACKAGE__->set_primary_key("keyword");


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2013-01-17 23:32:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HufiYobw0ZlYwCrWLZNbKQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
