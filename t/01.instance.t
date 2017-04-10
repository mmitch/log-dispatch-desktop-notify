#!perl
use Test::More tests => 2;

BEGIN { use_ok( 'Log::Dispatch::Desktop::Notify' ) }

subtest 'instance' => sub {
    my $obj = Log::Dispatch::Desktop::Notify->new();
    isa_ok( $obj, 'Log::Dispatch::Desktop::Notify' );
};
