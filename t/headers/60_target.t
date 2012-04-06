use strict;
use CGI::Simple;
use Test::More;

{
    my $q = CGI::Simple->new;
    my $got = $q->header({ target => 'ResultsWindow' });
    my $expected = 'Window-Target: ResultsWindow' . $q->crlf
                 . "Content-Type: text/html; charset=ISO-8859-1"
                 . $q->crlf x 2;
    is $got, $expected, 'target';
}

done_testing;
