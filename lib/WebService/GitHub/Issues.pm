use v6;

use WebService::GitHub;
use WebService::GitHub::Role;

class WebService::GitHub::Issues does WebService::GitHub::Role {

    method show(Str :$repo!, Str :$state = "open") {
	die X::AdHoc.new("State does not exist").throw if $state ne "open"|"closed"|"all" ;
	my $request = '/repos/' ~ $repo ~ '/issues';
	my $payload = '?state='~$state;
	self.request( $request ~ $payload ) ;
    }

    method single-issue(Str :$repo, Int :$issue ) {
      self.request('/repos/' ~ $repo ~ '/issues/' ~ $issue )
    }

    method all-issues(Str $repo ) {
	my @issues = self.show( repo => $repo, state => 'all' ).data.list;
	my @issue-data;
	say @issues;
	for @issues -> $i {
	    say "Limit → ", rate-limit-remaining();
	    say $i;
	    say $i<number>;
	    my $this-issue = self.single-issue( repo => $repo, issue => $i<number> ).data;
	    say $i;
	    for $this-issue.kv -> $k, $value { # merge issues
		say $k, $value;
		if ( ! $i<$k> ) {
		    $i<$k> = $value;
		}
	    }
	    @issue-data[ $i<number> ] = $i;

	}
    }
}
