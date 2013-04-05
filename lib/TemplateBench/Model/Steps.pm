package TemplateBench::Model::Steps;
use Mojo::Base '-base';

has groups => sub {
    use Data::Dumper;
    my $step_db = DB::Issue->load(100000);
    my $issue = DB::Issue->load(100000);
    my $step_status = DB::StepStatus->select( 'where issue_id = ?', $issue->id);
    my $step_group = DB::StepGroup->select();
    print Dumper($step_status);
    print Dumper($step_group);
    my $steps = [];
    for my $group (@{$step_group}) {
        DB::Step->iterate( 
            'where group_id = ? order by ?', $group->id, 'weight',
            sub {
                print Dumper($_);
        } );
    };
=test
    my $steps = [
        {
            title => "Code review",
            steps => [
                {type => "checkbox", name => "go_through", checked => $step_db->{go_through}, label => 'go through all files of review'},
                {type => "checkbox", name => "search", checked => $step_db->{search}, label => 'search for debugging symbols: <pre>$DB::single = 1;</pre> and <pre>console.log();</pre>'},
                {type => "checkbox", name => "leave", checked => $step_db->{leave}, label => 'leave at least one comment on code: <pre>"Looks good"</pre>'},
                {type => "checkbox", name => "mark_codestriker", checked => $step_db->{mark_codestriker}, label => 'mark code as reviewed in CodeStriker'},
                {type => "checkbox", name => "mark_netsuite", checked => $step_db->{mark_netsuite}, label => 'mark code as reviewed in NetSuite'},
                {type => "checkbox", name => "test", checked => $step_db->{test}, label => 'inform author about closed review to switch issue to QA testing state'},
            ],
        },
        {
            title => "Commit code",
            steps => [
                {type => "checkbox", name => "tidy_perl_code", checked => $step_db->{tidy_perl_code}, label => 'Check perl code <pre>make check && make tidy</pre>'},
                {type => "checkbox", name => "check_js_code", checked => $step_db->{check_js_code}, label => 'Check javascript code <pre>grunt</pre>'},
                {type => "checkbox", name => "create_diff", checked => $step_db->{create_diff}, label => 'Create diff <pre>git diff trunk</pre>'},
                {type => "checkbox", name => "upload_diff", checked => $step_db->{upload_diff}, label => 'Upload diff to <a href="https://cvs.openair1.com/codestriker">codestriker</a> and wait to code review'},
                {type => "checkbox", name => "apply_diff", checked => $step_db->{apply_diff}, label => 'Apply diff to CVS <pre>git cvsexportcommit -v -P -w ../tb.trunk trunk branch/enh</pre>'},
                {type => "checkbox", name => "cvs_commit", checked => $step_db->{cvs_commit}, label => 'Commit to CVS <pre>cvs commit -F .msg "Page.pm"</pre>'},
                {type => "checkbox", name => "mark_codestriker_commited", checked => $step_db->{mark_codestriker_commited}, label => 'Mark reivew commited in  <a href="https://cvs.openair1.com/codestriker">codestriker</a>'},
                {type => "checkbox", name => "set_issue_qa_testing", checked => $step_db->{set_issue_qa_testing}, label => 'Set status of issue to QA testing in <a href="http://www.netsuite.com/">NetSuite</a>'},
            ],
        },
        {
            title       => "(Hot|E)-Fix",
            description => "Follow general code check in instructions first",
            steps       => [
                        {type => "checkbox", name => "releasebranch", checked => $step_db->{releasebranch}, label => 'be sure that your code is built on current release branch (not trunk)'},
                        {type => "checkbox", name => "precommit", checked => $step_db->{precommit}, label => 'don\'t commit code before QA check'},
                        {type => "checkbox", name => "date", checked => $step_db->{date}, label => 'check issue release date in NetSuite - if missing, ask James Samspon to add one'},
                        {type => "checkbox", name => "patch", checked => $step_db->{patch}, label => 'prepare unified patch with <pre>diff -uN</pre>'},
                        {type => "checkbox", name => "reviewed", checked => $step_db->{reviewed}, label => 'let someone review your code'},
                        {type => "checkbox", name => "patchqa", checked => $step_db->{patchqa}, label => 'patch qa:1443 server with your patch <pre>ssh www-release@qa.openair1.com</pre> (leave patch on server for possible revert)'},
                        {type => "checkbox", name => "patchemail", checked => $step_db->{patchemail}, label => 'sent an email about patching with instructions, how to revert your patch'},
                        {type => "checkbox", name => "qastatus", checked => $step_db->{qastatus}, label => 'switch issue status in NetSuite system to QA-cell and add comment about patched sever'},
                        {type => "checkbox", name => "qacomplete", checked => $step_db->{qacomplete}, label => 'after positive QA response - update docs/delta.html with release date, patch instructions and issue info in actual hot fix release section'},
                        {type => "checkbox", name => "hotfixcommit", checked => $step_db->{hotfixcommit}, label => 'commit your changes to release branch including delta docs entry <pre>commit -m "IS:xxxxxx [issue description]" [files] ../docs/delta.html</pre>'},
                        {type => "checkbox", name => "efixcommit", checked => $step_db->{efixcommit}, label => 'store all changes in patches until E-Fix release date (commit all changes together to resease branch in the day of release of E-Fix - this will prevent conflicting commits from Hot-Fixes)'},
            ],
        },
    ];
=cut
    return $steps;
};

sub by_type {
    my $self = shift;
    my $type = shift;
    return($self->steps->{$type}) if ( exists($self->steps->{$type}) );
}

1;
