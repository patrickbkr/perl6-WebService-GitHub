use Test;
# -*- mode: perl6 -*-
use WebService::GitHub;

ok(1);
my $gh = WebService::GitHub.new;

if ((%*ENV<TRAVIS> && $gh.rate-limit-remaining()) || %*ENV<GH_TOKEN>) {
    diag "running on travis or with token";
    my $user = $gh.request('/users/fayland').data;
    is $user<login>, 'fayland', 'login ok';
    is $user<name>, 'Fayland Lam', 'name ok';
}

done-testing();
