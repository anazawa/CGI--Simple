use strict;
use CGI::Simple;
use Test::More;

{
    my $q = CGI::Simple->new;
    my $got = $q->header();
    my $expected = "Content-Type: text/html; charset=ISO-8859-1"
                 . $q->crlf x 2;
    is $got, $expected, 'default';
}

done_testing;
