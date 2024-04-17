package App::QRCodeUtils;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our %SPEC;

$SPEC{decode_qrcode} = {
    v => 1.1,
    summary => 'Decode QR Code',
    args => {
        filename => {
            schema => 'filename*',
            req => 1,
            pos => 0,
        },
    },
    examples => [
    ],
};
sub decode_qrcode {
    return [500, "Currently Image::DecodeQR cannot be built"];

    #require Image::DecodeQR;

    my %args = @_;

    my $str = Image::DecodeQR::decode($args{filename});

    [200, "OK", $str];
}

1;
#ABSTRACT: Utilities related to QR Code

=head1 DESCRIPTION

This distributions provides the following command-line utilities:

# INSERT_EXECS_LIST


=head1 SEE ALSO

L<App::GoogleAuthUtils>

=cut
