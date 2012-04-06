use strict;
use CGI::Simple;
use Test::More;

{
    my $q = CGI::Simple->new;
    my $got = $q->header({ nph => 1 });
    my $expected = '^HTTP/1.0 200 OK' . $q->crlf . 'Server: cmdline';
    like $got, qr($expected), 'nph';
}

done_testing;
