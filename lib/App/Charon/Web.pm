package App::Charon::Web;

# ABSTRACT: Internal (for now) Plack app behind charon

use utf8;
use Web::Simple;
use warnings NONFATAL => 'all';

use Plack::App::Directory;
use Plack::App::File;

has _quit => (
   is => 'ro',
   required => 1,
   init_arg => 'quit',
);

has _root => (
   is => 'ro',
   default => '.',
   init_arg => 'root',
);

has _query_param_auth => (
   is => 'ro',
   default => sub {
      require App::Genpass;
      [auth => scalar App::Genpass->new->generate]
   },
   init_arg => 'query_param_auth',
);

has _show_index => (
   is => 'ro',
   default => 1,
   init_arg => 'show_index',
);

sub BUILDARGS {
   my ($self, %params) = @_;

   $params{query_param_auth} = [split m/=/, $params{query_param_auth}, 2]
      if exists $params{query_param_auth};

   \%params
}

sub dispatch_request {
   my $self = shift;

   my $server = $self->_show_index
      ? 'Plack::App::Directory'
      : 'Plack::App::File';
   my @qpa = @{$self->_query_param_auth};
   (@qpa ? ( "?$qpa[0]~" => sub {
      my ($self, $value) = @_;

      return [403, ['Content-Type' => 'text/plain'], ['nice try']]
         if !$value || $value ne $qpa[1];
      return;
   }) : ()),
   '/quit' => sub { shift->_quit->done(1); [200, [], ''] },
   '/_/...' => sub { $server->new( root => shift->_root ) },
}

1;
