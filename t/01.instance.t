#!perl
use Test::More tests => 3;

use Test::Mock::Wrapper qw( Desktop::Notify );

BEGIN { use_ok( 'Log::Dispatch::Desktop::Notify' ) }

subtest 'instance' => sub {
    my $obj = Log::Dispatch::Desktop::Notify->new( min_level => 'warning' );
    isa_ok( $obj, 'Log::Dispatch::Desktop::Notify' );
};

subtest 'inheritance' => sub {
    my $obj = Log::Dispatch::Desktop::Notify->new( min_level => 'warning' );
    isa_ok( $obj, 'Log::Dispatch::Output' );
};

