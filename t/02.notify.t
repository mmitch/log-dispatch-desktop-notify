#!perl
use Test::More tests => 2;

use Test::Mock::Wrapper qw( Desktop::Notify );

BEGIN { use_ok( 'Log::Dispatch::Desktop::Notify' ) }

subtest 'Desktop::Notify instance' => sub {
    my $obj = Log::Dispatch::Desktop::Notify->new( min_level => 'warning' );
    isa_ok( $obj->{_notify}, 'Desktop::Notify' );
};
