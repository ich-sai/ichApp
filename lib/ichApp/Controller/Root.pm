package ichApp::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

ichApp::Controller::Root - Root Controller for ichApp

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	$c->go('/noodles/top_page');
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}



sub __report :Local {
	my ($self, $c) = @_;
	my (%user_agent, %referer);
	
	my $access_log = $c->config->{'access_log'};
	
	open my $fh , '<', $access_log or die;
	while (<$fh>) {
		my ($host, $ident, $user, $time, $request, $status, $bytes, $referer, $agent) =
  		$_ =~
  		/^([^ ]*) ([^ ]*) ([^ ]*) \[([^]]*)\] "(.*?)" ([^ ]*) ([^ ]*) "(.*?)" "(.*?)"/o;
  		$user_agent{$agent} += 1 if ( $agent ne '-' );
  		if ( ($referer ne '-')
  		     && ($referer !~ /www6012ui.sakura.ne.jp/)) {
			$referer =~ s/%([0-9a-fA-F][0-9a-fA-F])/chr(hex($1))/ego;
			$referer{$referer}  += 1;
		}
	}
	close $fh;
	
	my (@agent, @referer);
	foreach (sort {$user_agent{$b} <=> $user_agent{$a}} keys %user_agent) {
		push @agent, {'value'=>$_, 'count'=>$user_agent{$_}};
	}
	
	foreach (sort {$referer{$b} <=> $referer{$a}} keys %referer) {
		push @referer, {'value'=>$_, 'count'=>$referer{$_}};
	}
	$c->stash->{'list_user_agent'} = \@agent;
	$c->stash->{'list_referer'}    = \@referer;
}


=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
