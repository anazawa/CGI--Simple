use strict;
use CGI::Simple;
use Test::More;

{
    my $q = CGI::Simple->new;
    my $got = $q->header({ cookie => 'foo' });
    my $expected = qr{^Set-Cookie: foo};
    like $got, $expected, 'cookie';
}

{
    my $q = CGI::Simple->new;
    my $got = $q->header({ cookie => [ 'foo', 'bar' ]  });
    #my $expected = qr!^Set-Cookie: foo${CGI::CRLF}Set-Cookie: bar!;
    my $expected = '^Set-Cookie: foo' . $q->crlf . 'Set-Cookie: bar';
    like $got, qr($expected), 'cookie arrayref';
}

{
    my $q = CGI::Simple->new;
    my $got = $q->header({ cookie => q{} });
    my $expected = "Content-Type: text/html; charset=ISO-8859-1"
                 . $q->crlf x 2;
    is $got, $expected, 'cookie empty string';
}

TODO: {
    local $TODO
        = "CGI::header() outputs both of Set-cookie & Set-Cookie headers";
    my $q = CGI::Simple->new;
    my $got = $q->header({
        cookie       => 'foo',
        'Set-Cookie' => 'bar',
    });
    my $expected = "^Set-Cookie: foo" . $q->crlf
                 . "Date: [^" . $q->crlf . "]+" . $q->crlf
                 . "Set-cookie: bar" . $q->crlf;
    like $got, qr($expected), 'cookie & set-cookie';
}

TODO: {
    local $TODO
        = "CGI::header() outputs both of Set-cookie & Set-Cookie headers";
    my $q = CGI::Simple->new;
    my $got = $q->header({
        cookie       => [ 'foo', 'bar' ],
        'Set-Cookie' => 'baz',
    });
    my $expected = "^Set-Cookie: foo" . $q->crlf
                 . "Set-Cookie: bar" . $q->crlf
                 . "Date: [^" . $q->crlf . "]+" . $q->crlf
                 . "Set-cookie: baz" . $q->crlf;
    like $got, qr($expected), 'cookie & set-cookie, cookie is arrayref';
}

SKIP: {
    skip "CGI::header() doesn't output the Date header", 1;
    my $q = CGI::Simple->new;
    my $got = $q->header({
        cookie       => q{},
        'Set-Cookie' => 'foo',
    });
    my $expected = "Set-cookie: foo" . $q->crlf
                 . "Content-Type: text/html; charset=ISO-8859-1"
                 . $q->crlf x 2;
    is $got, $expected, 'cookie & set-cookie, cookie is empty string';
}

done_testing;
