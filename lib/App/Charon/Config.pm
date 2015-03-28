package App::Charon::Config;

use utf8;
use Moo;
use warnings NONFATAL => 'all';

has [qw(listen autoshutdown query_param_auth index)] => (
   is => 'ro',
   predicate => 1,
);

sub opt_default_for {
   my ($self, $attr, @default) = @_;

   my $pred = "has_$attr";
   if ($self->$pred) {
      return { default => $self->$attr }
   } else {
      return @default
   }
}

1;
