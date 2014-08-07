package ichApp::Controller::Response;
use Moose;
use namespace::autoclean;
use DateTime;
use MIME::Base64;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ichApp::Controller::Response - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ichApp::Controller::Response in Response.');
}

sub auth :Local {
	my ($self, $c) = @_;
	my $auth = $c->req->header('Authorization');
	
	if ( $auth eq '' ) {
		$c->res->status(401);
		$c->res->header(
			'WWW-Authenticate' => 'Basic realm="catalyst"');
		$c->res->body('このページには認証が必要です');
	}
	else {
		my @usr = split /:/, decode_base64(substr($auth, 6));
		if ( $usr[0] ne 'hoge' || $usr[1] ne 'boyo' ) {
			$c->res->body('まちがってます');
		}
	}
}


sub refresh :Local {
	my ($self, $c) = @_;
	
	$c->res->header('Refresh' => 5 );
	my $dt = DateTime->now(time_zone => 'local');
	$c->stash->{'now'} = $dt->strftime('%Y/%m/%d %H:%M:%S');
}

sub download :Local {
	my ($self, $c) = @_;
	
	$c->res->header(
		'Content-Type' => 'application/octet-stream',
		'Content-Disposition' => 'attachement; filename="dl.csv"',
		);
	$c->stash->{'list'} = [$c->model('Noodles::NoodleImpression')->all];
}

sub redirect :Local {
	my ($self, $c) = @_;
	
	$c->res->redirect('/noodles/list');
}



=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
