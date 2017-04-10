use Mock::Quick;

our $notification_mock = qclass(
    -implement => 'Desktop::Notify::Notification',
    -with_new => 1,
    -attributes => [ qw( message ) ]
    );

our $notify_mock = qclass(
    -implement => 'Desktop::Notify',
    -with_new => 1,
    create => sub {
	return $notification_mock->package->new;
    }
    );

1;
