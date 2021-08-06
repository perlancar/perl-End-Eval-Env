package End::Eval::Env;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;

my @envs;
sub import {
    my $class = shift;
    push @envs, @_;
}

END {
    push @envs, 'PERL_END_EVAL_ENV' unless @envs;
    for my $env (@envs) {
        next unless defined $ENV{$env};
        print "DEBUG: eval-ing ENV{$env}: $ENV{$env} ...\n" if $ENV{DEBUG};
        eval "no strict; no warnings; $ENV{$env};";
        die if $@;
    }
}

1;
# ABSTRACT: Take code from environment variable(s), then eval it in END block

=head1 SYNOPSIS

On the command-line:

 % PERL_END_EVAL_ENV='use Data::Dump; dd \%INC' perl -MEnd::Eval::Env `which some-perl-script.pl` ...
 % PERL_END_EVAL_ENV='use Data::Dump; dd \%INC' PERL5OPT=-MEnd::Eval::Env some-perl-script.pl ...

Customize the environment variables:

 % perl -MEnd::Eval::Env=ENVNAME1,ENVNAME2 `which some-perl-script.pl` ...
 % PERL5OPT=-MEnd::Eval::Env=ENVNAME1,ENVNAME2 some-perl-script.pl ...


=head1 DESCRIPTION

This module allows you to specify code(s) in environment variable(s), basically
for convenience in one-liners. If name(s) of environment variables are not
specified, C<PERL_END_EVAL_ENV> is the default.


=head1 ENVIRONMENT

=head2 PERL_END_EVAL_END


=head1 SEE ALSO

Other C<End::Eval::*> (like L<End::Eval> and L<End::Eval::FirstArg>) and
C<End::*> modules.

Other C<Devel::End::*> modules (but this namespace is deprecated in favor of
C<End>).

=cut
