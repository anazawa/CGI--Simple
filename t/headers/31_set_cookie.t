use strict;
use CGI::Simple;
use Test::More;

SKIP: {
    skip "CGI::header() doesn't output the Date header", 1;
    my $q = CGI::Simple->new;
    my $got = $q->header({ 'Set-Cookie' => 'foo' });
    my $expected = "Set-cookie: foo" . $q->crlf
                 . "Content-Type: text/html; charset=ISO-8859-1"
                 . $q->crlf x 2;
    is $got, $expected, 'set-cookie';
}

SKIP: {
    skip "CGI::header() may have a bug here", 1;
    my $q = CGI::Simple->new;
    my $got = $q->header({ 'Set-Cookie' => q{} });
    my $expected = 'Set-cookie: \"' . $q->crlf # looks like a bug
                 . "Content-Type: text/html; charset=ISO-8859-1"
                 . $q->crlf x 2;
    is $got, $expected, 'set-cookie empty string';
}

done_testing;
