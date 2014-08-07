package ichApp::Controller::Request;
use Moose;
use namespace::autoclean;
use Encode;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ichApp::Controller::Request - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ichApp::Controller::Request in Request.');
}

sub my_agent :Local {
	my ($self, $c) = @_;
	
	$c->response->body($c->config->{'my_agent'});
}
	
sub form :Local {}
sub query :Local {}
sub process :Local {
	my ($self, $c) = @_;
	$c->stash->{'nam_body_params'} = $c->request->body_params->{'nam'};
	$c->stash->{'nam_query_params'} = $c->req->query_params->{'nam'};
	$c->stash->{'nam_param'} = $c->request->param('nam');
}


sub multiForm :Local {}

sub multiProcess :Local {
	my ($self, $c) = @_;
	my $fw = $c->req->body_params->{'fw'};
	$c->stash->{'fw_body_params'} = join ',', @{$fw};
	my @fw = $c->req->param('fw');
	$c->stash->{'fw_param'} = join ',' , @fw;
}

#-------------------------------------------------------------------------------------

sub upload :Local {}

sub uploadProcess :Local {
	my ($self, $c) = @_;

	my $msg;
	my $upload = $c->req->upload('upfile');
	my $file = $upload->filename();
	$file =~ /([^\\\/]+$)/;
	my $base = $1;
	
	Encode::from_to($base, 'utf8', 'shiftjis');
	
	if ( $upload->copy_to("./doc/$base")) {
		$msg = $file . 'をアップロードしました。';
	}
	else {
		$msg = '処理中にエラーが発生しました。';
	}
	
	$c->res->body($msg);
}

#-------------------------------------------------------------------------------------
sub headers :Local {
	my ($self, $c) = @_;
	my $result = q();
	my $hs = $c->req->headers;
	foreach my $name ($hs->header_field_names) {
		$result .= $name . ':' . $hs->header($name) . '<br/>';
	}
	$c->res->body($result);
}
#-------------------------------------------------------------------------------------

sub cookie :Local {
	my ($self, $c) = @_;
	
	my $email = $c->req->cookie('email');
	$c->stash->{'email'} = $email ? $email->value : q();
}

sub cookieProcess :Local {
	my ($self, $c) = @_;
	
	$c->res->cookies->{'email'} = {
		value => $c->req->body_params->{'email'},
		expires => '+3M',
	};
	$c->res->body('クッキーを保存しました');
}

sub tt_vars :Local {
	my ($self, $c) = @_;
	
	$c->stash->{'array_t'} = ['hoge', 'fuga', 'boyo'];
	my $arg = $c->request->args->[0] || 0;
	if ( $arg < 0 ) {
		$arg = 0;
	}
	if ( $arg > 2 ) {
		$arg = 2;
	}
	$c->stash->{'index'} = $arg;
}



=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
