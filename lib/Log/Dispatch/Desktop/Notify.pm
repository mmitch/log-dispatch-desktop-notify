use strict;
use warnings;
# Copyright (C) 2017,2018  Christian Garbs <mitch@cgarbs.de>
# Licensed under GNU GPL v2 or later.

package Log::Dispatch::Desktop::Notify;

# ABSTRACT: Log::Dispatch notification backend using Desktop::Notify

use Desktop::Notify;
use Log::Dispatch::Null;
use Try::Tiny;

use parent 'Log::Dispatch::Output';

=head1 SYNOPSIS

    use Log::Dispatch;
    use Log::Dispatch::Desktop::Notify;

    my $log = Log::Dispatch->new();

    $log->add( Log::Dispatch::Desktop::Notify->new(
                 min_level => 'warning'
               ));

    $log->log( level => 'warning', message => 'a problem!' );

=head1 DESCRIPTION

Log::Dispatch::Desktop::Notify is a backend for L<Log::Dispatch> that
displays messages via the Desktop Notification Framework (think
C<libnotify>) using L<Desktop::Notify>.

=head1 METHODS

=head2 new

Creates a new L<Log::Dispatch::Desktop::Notify> object.  Expects named
parameters as a hash.  In addition to the usual parameters of
L<Log::Dispatch::Output> these parameters are also supported:

=over

=item timeout

Default value: C<-1>

Sets the message timeout in milliseconds.  C<0> disables the timeout,
the message has to be closed manually.  C<-1> uses the default timeout
of the notification server.

=item app_name

Default value: C<$0> (script name)

Sets the application name for the message display.

=back

Note: If L<Desktop::Notify> can't establish a Dbus session (no
messages can be sent), a L<Log::Dispatch::Null> object is returned
instead.

=cut

sub new {
    my ($class, %params) = @_;

    if (_desktop_notify_unavailable()) {
	return Log::Dispatch::Null->new(%params);
    };

    my $self = bless {
	_timeout  => -1,
	_app_name => $0,
    }, $class;

    $self->_basic_init(%params);
    $self->_init(%params);

    return $self;
};

sub _init {
    my ($self, %params) = @_;

    $self->{_app_name} = $params{app_name} if defined $params{app_name};
    $self->{_timeout}  = $params{timeout}  if defined $params{timeout};

    $self->{_notify} = Desktop::Notify->new( app_name => $self->{_app_name} );
};

sub _desktop_notify_unavailable {
    return try {
	Desktop::Notify->new();
	0;
    } catch {
	1;
    }
}

=head2 log_message

This method is called internally by C<Log::Dispatch::log()> to
display a message.  Expects named parameters in a hash.  Currently,
only the usual L<Log::Dispatch::Output> parameters C<level> and
C<message> are supported.

=cut

sub log_message {
    my ($self, %params) = @_;

    my $notification = $self->{_notify}->create(
	summary => $params{message},
	timeout => $self->{_timeout},
	);

    $notification->show();
};

=head1 BUGS AND LIMITATIONS

To report a bug, please use the github issue tracker:
L<https://github.com/mmitch/log-dispatch-desktop-notify/issues>

=head1 AVAILABILITY

=over

=item github repository

L<git://github.com/mmitch/log-dispatch-desktop-notify.git>

=item github browser

L<https://github.com/mmitch/log-dispatch-desktop-notify>

=item github issue tracker

L<https://github.com/mmitch/log-dispatch-desktop-notify/issues>

=back

=begin html

=head1 BUILD STATUS

<p><a href="https://travis-ci.org/mmitch/log-dispatch-desktop-notify"><img src="https://travis-ci.org/mmitch/log-dispatch-desktop-notify.svg?branch=master" alt="Build Status"></a></p>

=end html

=begin html

=head1 TEST COVERAGE

<p><a href="https://codecov.io/github/mmitch/log-dispatch-desktop-notify?branch=master"><img src="https://codecov.io/github/mmitch/log-dispatch-desktop-notify/coverage.svg?branch=master" alt="Coverage Status"></a></p>

=end html

=head1 SEE ALSO

=over

=item *

L<Log::Dispatch>

=item *

L<Desktop::Notify>

=back

=cut

1;
