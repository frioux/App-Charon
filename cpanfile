requires 'IO::Async';
requires 'Net::Async::HTTP::Server::PSGI';
requires 'Web::Simple';
requires 'Plack::App::Directory';
requires 'Plack::App::File';
requires 'Getopt::Long::Descriptive';
requires 'IO::All';
requires 'Time::Duration::Parse';
requires 'App::Genpass';
requires 'IO::Socket::IP';

on test => sub {
   requires 'Test::More' => 1;
};
