use strict;
use CGI::Simple;
use Test::More;

{
    my $q = CGI::Simple->new;
    my $got = $q->header({ 'Content-Type' => 'text/plain; charset=utf-8' });
    my $expected = "Content-Type: text/plain; charset=utf-8"
                 . $q->crlf x 2;
    is $got, $expected, 'content-type';
}

{
    my $q = CGI::Simple->new;
    my $got = $q->header({ 'Content-Type' => 'text/plain' });
    my $expected = "Content-Type: text/plain; charset=ISO-8859-1"
                 . $q->crlf x 2;
    is $got, $expected, 'content-type without charset';
}

{
    my $q = CGI::Simple->new;
    my $got = $q->header({ 'Content-Type' => q{} });
    my $expected = $q->crlf x 2;
    is $got, $expected, 'content-type empty string';
}

{
    my $q = CGI::Simple->new;
    my $got = $q->header({ 'Content-Type' => 'charset=utf-8' });
    my $expected = "Content-Type: charset=utf-8" . $q->crlf x 2;
    is $got, $expected, 'content-type edge case';
}

done_testing;
