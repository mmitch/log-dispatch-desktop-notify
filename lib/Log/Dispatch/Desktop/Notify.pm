use strict;
use warnings;
# Copyright (C) 2017  Christian Garbs <mitch@cgarbs.de>
# Licensed under GNU GPL v2 or later.

package Log::Dispatch::Desktop::Notify;
# ABSTRACT: Log::Dispatch notification backend using Desktop::Notify


=head1 SYNOPSIS

    use Log::Dispatch::Desktop::Notify;

=head1 DESCRIPTION

=head1 INTERFACE

=head1 CONFIGURATION AND ENVIRONMENT

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

use parent 'Log::Dispatch::Output';

use Class::Tiny;

sub new {
    my ($class, %params) = @_;

    my $self = bless {}, $class;
    $self->_basic_init(%params);
    return $self;
};

1;
