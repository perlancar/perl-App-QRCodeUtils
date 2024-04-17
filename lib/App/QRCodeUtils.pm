package App::QRCodeUtils;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

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

$SPEC{gen_qrcode} = {
    v => 1.1,
    summary => 'Generate QR Code and by default show it (or save it to a file)',
    args => {
        text => {
            schema => 'str*',
            req => 1,
            pos => 0,
        },
        filename => {
            schema => 'filename*',
            pos => 1,
            description => <<'MARKDOWN',

If unspecified, will save to a temporary filename and show it with
<pm:Desktop::Open>.

MARKDOWN
        },
        format => {
            schema => ['str*', in=>[qw/png html txt/]],
            default => 'png',
        },
    },
    examples => [
    ],
};
sub gen_qrcode {
    require QRCode::Any;

    my %args = @_;
    my $format = $args{format};

    my $filename = $args{filename};
    unless (defined $filename) {
        require File::Temp;
        (undef, $filename) = File::Temp::tempfile("qrcodeXXXXXXXXX", SUFFIX=>".$format");
    }

    my $res = QRCode::Any::encode_qrcode(
        format => $format,
        text => $args{text},
        filename => $filename,
    );
    return $res unless $res->[0] == 200;

    require Desktop::Open;
    Desktop::Open::open_desktop($filename);

    [200];
}

1;
#ABSTRACT: Utilities related to QR Code

=head1 DESCRIPTION

This distributions provides the following command-line utilities:

# INSERT_EXECS_LIST


=head1 SEE ALSO

L<App::GoogleAuthUtils>

=cut
