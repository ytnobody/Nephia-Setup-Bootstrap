use strict;
use warnings;
use Test::More;
use Nephia::Setup;
use Capture::Tiny 'capture';
use File::Temp 'tempdir';
use Plack::Test;
use Guard;
use Cwd;

my $pwd = getcwd;

my $dir = tempdir(CLEANUP => 1);
chdir $dir;

my $guard = guard { chdir $pwd };

my $setup = Nephia::Setup->new(
    appname => 'Verdure::Memory',
    flavor  => 'Bootstrap',
);

isa_ok $setup, 'Nephia::Setup::Bootstrap';
can_ok $setup, 'create';

my($out, $err, @res) = capture {
    $setup->create;
};

is $err, '', 'setup error';
my $expect = join ('', (<DATA>));
like $out, qr/$expect/, 'setup step';

undef($guard);

done_testing;
__DATA__
create path Verdure-Memory/root/static/bootstrap
create path Verdure-Memory/root/static/bootstrap/css
create path Verdure-Memory/root/static/bootstrap/js
create path Verdure-Memory/root/static/bootstrap/img
create path Verdure-Memory/root/static/js
spew into file Verdure-Memory/root/static/bootstrap/css/bootstrap-responsive.css
spew into file Verdure-Memory/root/static/bootstrap/css/bootstrap-responsive.min.css
spew into file Verdure-Memory/root/static/bootstrap/css/bootstrap.css
spew into file Verdure-Memory/root/static/bootstrap/css/bootstrap.min.css
spew into file Verdure-Memory/root/static/bootstrap/img/glyphicons-halflings-white.png
spew into file Verdure-Memory/root/static/bootstrap/img/glyphicons-halflings.png
spew into file Verdure-Memory/root/static/bootstrap/js/bootstrap.js
spew into file Verdure-Memory/root/static/bootstrap/js/bootstrap.min.js
spew into file Verdure-Memory/root/static/js/jquery.js
