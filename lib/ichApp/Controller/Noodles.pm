package ichApp::Controller::Noodles;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ichApp::Controller::Noodles - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	
	$c->go('/noodles/top_page');
}

sub top_page :Local {
	my ($self, $c) = @_;
	
	$c->stash->{'list'} = [
		$c->model('Noodles::DisplayList')->search(undef,{
			rows => $c->config->{'list_line_size'},
			page => 1,
		})
	];
}

sub intro :Local {
	my ($self, $c) = @_;
	$c->response->body('麺が好き！');
}

sub introView :Local {
	my ($self, $c) = @_;
	$c->stash->{'msg'} = '麺が好き!';
}

sub list :Local {
	my ($self, $c, $page) = @_;

	if ( ! defined $page ) { $page = 1 }

	my $count = $c->model('Noodles::DisplayList')->search(undef)->count();
	my $page_lines = $c->config->{'list_line_size'};
	my $pages = int($count/$page_lines);
	$pages += 1 if ( $count % $page_lines );
	
	$c->stash->{'pages'} = $pages;
	$c->stash->{'page'}  = $page;
	$c->stash->{'list'}  = [
		$c->model('Noodles::DisplayList')->search(undef,
			{rows=>$page_lines, page=>$page}
		)];
	$c->session->{'screen'} = 'list';
	$c->session->{'page'}   = $page;
}

sub detail :Local {
	my ($self, $c, $id) = @_;

	if ( defined($id) ) {
		$c->stash->{'noodle'} = $c->model('Noodles::NoodleImpression')->find($id);
	}
	$c->stash->{'screen'} = $c->session->{'screen'};
	$c->stash->{'page'}   = $c->session->{'page'};
}

sub search_form :Local {
	my ($self, $c) = @_;
	
	$c->stash->{'vendors'} = [$c->model('Noodles::VendorList')->all];
}

sub search_result :Local {
	my ($self, $c, $page) = @_;
	
	my ($vendor, $bland, $free_word);
	if ( $page ) {
		# $page is defined -> page transition
		if ( $c->session() ) {
			#  valid session
			$vendor    = $c->session->{'vendor'};
			$bland     = $c->session->{'bland'};
			$free_word = $c->session->{'free_word'};
		}
		else {
			# no session
			$vendor    = '';
			$bland     = '';
			$free_word = '';
		}
	}
	else {
		# $page is undef -> new search request
		$page = 1;
		$vendor    = $c->request->body_params->{'vendor'};
		$bland     = $c->request->body_params->{'bland'};
		$free_word = $c->request->body_params->{'free_word'};
	}

	my $where = {};
	if ( $vendor ne '' ) {
		$where->{'vendor'} = {'=' => $vendor};
	}
	
	if ( $bland ne '' ) {
		$where->{'name'} = {'LIKE' => '%'.$bland.'%'};
	}

	if ( $free_word ne '' ) {
		$where->{'free_word_search'} = {'LIKE' => '%'.$free_word.'%'};
	}

	my $my_model;
	if ( $c->config->{'my_agent'} eq $c->request->user_agent() ) {
		$my_model = $c->model('Noodles::DisplayListAll');
	}
	else {
		$my_model = $c->model('Noodles::DisplayList')
	}
	my $count = $my_model->search($where)->count();
	my $list_lines = $c->config->{'list_line_size'};
	my $pages = int($count / $list_lines);
	$pages += 1 if ( $count % $list_lines);
	
	#-------------------------------
	# set body parms to session
	#-------------------------------
	$c->session->{'vendor'}    = $vendor;
	$c->session->{'bland'}     = $bland;;
	$c->session->{'free_word'} = $free_word;
	$c->session->{'screen'}    = 'search_result';
	$c->session->{'page'}      = $page;
	
	#-------------------------------
	# set res for TT
	#-------------------------------
	$c->stash->{'page'}      = $page;
	$c->stash->{'pages'}     = $pages;
	$c->stash->{'vendor'}    = $vendor;
	$c->stash->{'bland'}     = $bland;
	$c->stash->{'free_word'} = $free_word;
	$c->stash->{'list'}      = [$my_model->search($where,{rows=>$list_lines, page=>$page, order_by=>{-desc=>'date_of_eaten'}})];
}




=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
