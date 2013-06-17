package Nephia::Setup::Bootstrap;
use strict;
use warnings;
use parent qw( Nephia::Setup::Base );

use Nephia::Setup::Bootstrap::TwitterBootstrap;
use Nephia::Setup::Bootstrap::jQuery;

our $VERSION = "0.01";

sub css_file {
    my $self = shift;
    my $bootstrap_files = Nephia::Setup::Bootstrap::TwitterBootstrap::files;
    my $jquery_files    = Nephia::Setup::Bootstrap::jQuery::files;

    map {
        my @path = split '/', $_;
        $self->mkpath($self->approot, qw/root static/, @path);
    } qw( bootstrap bootstrap/css bootstrap/js bootstrap/img js );

    for (sort keys %{$bootstrap_files}) {
        my $file = File::Spec->catfile($self->approot, qw/root static/, (split /\//, $_));
        $self->spew($file, $bootstrap_files->{$_});
    }

    for (sort keys %{$jquery_files}) {
        my $file = File::Spec->catfile($self->approot, qw/root static/, (split /\//, $_));
        $self->spew($file, $jquery_files->{$_});
    }
}

1;
__DATA__

index_template_file
---
? my $c = shift;
<html>
<head>
  <title><?= $c->{title} ?> - powerd by Nephia</title>
  <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.css" />
  <link rel="shortcut icon" href="/static/favicon.ico" />
  <script src="/static/bootstrap/js/bootstrap.js"></script>
  <script src="/static/js/jquery.js"></script>
  <style>
    body {
      padding-top: 60px;
    }
  </style>
</head>
<body>

  <div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container">
        <span class="brand"><?= $c->{title} ?> <small>(<?= $c->{envname} ?>)</small></span>
      </div>
    </div>
  </div>

  <div class="container">
    <h2>Hello, Nephia world!</h2>
    <p>Nephia is a mini web-application framework.</p>
    <pre>
    ### <?= $c->{apppath} ?>
    use Nephia;

    # <a href="/data">JSON responce sample</a>
    path '/data' => sub {
        my $req = shift;

        return { # responce-value as JSON unless exists {template}
            #template => 'index.tx',
            title    => config->{appname},
            envname  => config->{envname},
        };
    };
    </pre>
    <h2>See also</h2>
    <ul>
      <li><a href="https://metacpan.org/module/Nephia">Read the documentation</a></li>
    </ul>

    <footer>
      <p class="pull-right">Generated by Nephia</p>
    </footer>
  </div>
</body>
</html>

===
=encoding utf-8

=head1 NAME

Nephia::Setup::Bootstrap - Adding flavor for Nephia

=head1 SYNOPSIS

    % nephia-setup MyApp --flavor=Bootstrap

=head1 DESCRIPTION

This is a adding flavor for Nephia. This flavor prepares the Twitter Bootstrap and jQuery.
This module is developed in reference to Amon2::Setup::Basic.

=head1 LICENSE

Copyright (C) papix.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

papix E<lt>mail@papix.netE<gt>

=cut

