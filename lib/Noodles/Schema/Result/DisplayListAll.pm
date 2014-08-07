use utf8;
package Noodles::Schema::Result::DisplayListAll;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Noodles::Schema::Result::DisplayListAll

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

=head1 TABLE: C<display_list_all>

=cut

__PACKAGE__->table("display_list_all");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 1

=head2 date_of_eaten

  data_type: (empty string)
  is_nullable: 1

=head2 edition

  data_type: (empty string)
  is_nullable: 1

=head2 vendor

  data_type: (empty string)
  is_nullable: 1

=head2 vendor_url

  data_type: (empty string)
  is_nullable: 1

=head2 name

  data_type: (empty string)
  is_nullable: 1

=head2 photo_url

  data_type: (empty string)
  is_nullable: 1

=head2 text

  data_type: (empty string)
  is_nullable: 1

=head2 impression_rank

  data_type: (empty string)
  is_nullable: 1

=head2 impression_text

  data_type: (empty string)
  is_nullable: 1

=head2 free_word_search

  data_type: (empty string)
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 1 },
  "date_of_eaten",
  { data_type => "", is_nullable => 1 },
  "edition",
  { data_type => "", is_nullable => 1 },
  "vendor",
  { data_type => "", is_nullable => 1 },
  "vendor_url",
  { data_type => "", is_nullable => 1 },
  "name",
  { data_type => "", is_nullable => 1 },
  "photo_url",
  { data_type => "", is_nullable => 1 },
  "text",
  { data_type => "", is_nullable => 1 },
  "impression_rank",
  { data_type => "", is_nullable => 1 },
  "impression_text",
  { data_type => "", is_nullable => 1 },
  "free_word_search",
  { data_type => "", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2013-01-17 23:32:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XvdyIwrI2pEUMhocriMBAA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
