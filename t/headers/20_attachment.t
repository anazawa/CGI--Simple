use strict;
use CGI::Simple;
use Test::More;

{
    my $q = CGI::Simple->new;
    my $got = $q->header({ attachment => 'foo.png' });
    my $expected = qr!^Content-Disposition: attachment; filename="foo.png"!;
    like $got, $expected, 'attachment';
}

{
    my $q = CGI::Simple->new;
    my $got = $q->header({ attachment => q{} });
    my $expected = "Content-Type: text/html; charset=ISO-8859-1"
                 . $q->crlf x 2;
    is $got, $expected, 'attachment empty string';
}

{
    my $q = CGI::Simple->new;
    my $got = $q->header({
        'Content-Disposition' => 'attachment; filename="foo.png"'
    });
    my $expected = qr!^Content-disposition: attachment; filename="foo.png"!;
    like $got, $expected, 'content-disposition';
}

{
    my $q = CGI::Simple->new;
    my $got = $q->header({
        'Content-Disposition' => 'attachment; filename="foo.png"',
        attachment            => 'bar.png',
    });
    my $expected = qr!^Content-Disposition: attachment; filename="bar.png"!;
    like $got, $expected, 'content-disposition';
}

done_testing;
