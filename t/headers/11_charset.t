use strict;
use CGI::Simple;
use Test::More;

{
    my $q = CGI::Simple->new;
    my $got = $q->header({ charset => 'utf-8' });
    my $expected = "Content-Type: text/html; charset=utf-8"
                 . $q->crlf x 2;
    is $got, $expected, 'charset';
}

TODO: {
    #skip "CGI::header doesn't output charset", 1;
    local $TODO = "CGI::header doesn't output charset";
    #ocal $TODO =
    my $q = CGI::Simple->new;
    my $got = $q->header({ charset => q{} });
    my $expected = "Content-Type: text/html" . $q->crlf x 2;
    is $got, $expected, 'charset empty string';
}

{
    my $q = CGI::Simple->new;
    my $got = $q->header({
        'Content-Type' => 'text/plain; charset=EUC-JP',
        charset        => 'utf-8'
    });
    my $expected = "Content-Type: text/plain; charset=EUC-JP"
                 . $q->crlf x 2;
    is $got, $expected, 'content-type and charset';
}

{
    my $q = CGI::Simple->new;
    my $got = $q->header({
        'Content-Type' => 'text/plain; charset=EUC-JP',
        charset        => q{},
    });
    my $expected = "Content-Type: text/plain; charset=EUC-JP"
                 . $q->crlf x 2;
    is $got, $expected, 'content-type & charset, charset is empty string';
}

{
    my $q = CGI::Simple->new;
    my $got = $q->header({
        'Content-Type' => q{},
        charset        => 'utf-8',
    });
    my $expected = $q->crlf x 2;
    is $got, $expected, 'content-type & charset, content-type is empty string';
}

{
    my $q = CGI::Simple->new;
    my $got = $q->header({
        'Content-Type' => 'text/plain',
        charset        => 'utf-8',
    });
    my $expected = "Content-Type: text/plain; charset=utf-8"
                 . $q->crlf x 2;
    is $got, $expected, 'content-type & charset, charset defines charset';
}

done_testing;
