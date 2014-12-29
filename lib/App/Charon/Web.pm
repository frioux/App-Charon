package App::Charon::Web;

use utf8;
use Web::Simple;
use warnings NONFATAL => 'all';

use Plack::App::Directory;

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

sub dispatch_request {
   '/quit' => sub { shift->_quit->done(1); [200, [], ''] },
   '/...' => sub { Plack::App::Directory->new( root => shift->_root ) },
}

1;
