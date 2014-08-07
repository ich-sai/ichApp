package ichApp::Controller::Context;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ichApp::Controller::Context - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ichApp::Controller::Context in Context.');
}

sub conf :Local {
	my ($self, $c) = @_;
	
	my $conf = $c->config;
	foreach (keys %{$conf}) {
		$c->res->write(sprintf("%s => %s \n", $_, $conf->{$_}));
	}
	$c->res->body(q());
}

sub urifor :Local {
	my ($self, $c) = @_;
	
	my $msg;
	
	$msg = $c->uri_for . '<br/';
	
	$c->res->body($msg);
}


=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
