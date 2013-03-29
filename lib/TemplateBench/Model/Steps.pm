package TemplateBench::Benchmark::Model::Steps;
use Mojo::Base -base;

has steps => {
    code_review => {
        title => "Code review",
        items => [
            {type => "checkbox", name => "go_through",       label => "Go through all files of review"},
            {type => "checkbox", name => "search",           label => "search for debugging symbols: "},
            {type => "checkbox", name => "leave",            label => "leave at least one comment on code: "},
            {type => "checkbox", name => "mark_codestriker", label => "mark code as reviewed in CodeStriker"},
            {type => "checkbox", name => "mark_netsuite",    label => "mark code as reviewed in NetSuite"},
            {   type  => "checkbox",
                name  => "test",
                label => "inform author about closed review to switch issue to QA testing state"
            },
        ],
    },
    commit_code => {
        title => "Commit code",
        items => [
            {type => "checkbox", name => "tidy_perl_code",            label => "Check perl code "},
            {type => "checkbox", name => "check_js_code",             label => "Check javascript code "},
            {type => "checkbox", name => "create_diff",               label => "Create diff "},
            {type => "checkbox", name => "upload_diff",               label => "Upload diff to "},
            {type => "checkbox", name => "apply_diff",                label => "Apply diff to CVS "},
            {type => "checkbox", name => "cvs_commit",                label => "Commit to CVS "},
            {type => "checkbox", name => "mark_codestriker_commited", label => "Mark reivew commited in  "},
            {type => "checkbox", name => "set_issue_qa_testing",      label => "Set status of issue to QA testing in "},
        ],
    },
    hot_fix => {
        title       => "(Hot|E)-Fix",
        description => "Follow general code check in instructions first",
        items       => [{
                type  => "checkbox",
                name  => "releasebranch",
                label => "be sure that your code is built on current release branch (not trunk)"
            },
            {type => "checkbox", name => "precommit", label => "don't commit code before QA check"},
            {   type  => "checkbox",
                name  => "date",
                label => "check issue release date in NetSuite - if missing, ask James Samspon to add one"
            },
            {type => "checkbox", name => "patch",    label => "prepare unified patch with "},
            {type => "checkbox", name => "reviewed", label => "let someone review your code"},
            {type => "checkbox", name => "patchqa",  label => "patch qa:1443 server with your patch "},
            {   type  => "checkbox",
                name  => "patchemail",
                label => "sent an email about patching with instructions, how to revert your patch"
            },
            {   type  => "checkbox",
                name  => "qastatus",
                label => "switch issue status in NetSuite system to QA-cell and add comment about patched sever"
            },
            {   type => "checkbox",
                name => "qacomplete",
                label =>
                  "after positive QA response - update docs/delta.html with release date, patch instructions and issue info in actual hot fix release section"
            },
            {   type => "checkbox",
                name => "efixcommit",
                label =>
                  "store all changes in patches until E-Fix release date (commit all changes together to resease branch in the day of release of E-Fix - this will prevent conflicting commits from Hot-Fixes)"
            },
            {   type  => "checkbox",
                name  => "hotfixcommit",
                label => "commit your changes to release branch including delta docs entry "
            },
        ],
    },
    code_review => {
        title       => "Hot-Fix",
        description => "Follow general code check in instructions first",
        items       => [{
                type  => "checkbox",
                name  => "releasebranch",
                label => "be sure that your code is built on current release branch (not trunk)"
            },
            {type => "checkbox", name => "precommit", label => "don't commit code before QA check"},
            {   type  => "checkbox",
                name  => "date",
                label => "check issue release date in NetSuite - if missing, ask James Samspon to add one"
            },
            {type => "checkbox", name => "patch",    label => "prepare unified patch with "},
            {type => "checkbox", name => "reviewed", label => "let someone review your code"},
            {type => "checkbox", name => "patchqa",  label => "patch qa:1443 server with your patch "},
            {   type  => "checkbox",
                name  => "patchemail",
                label => "sent an email about patching with instructions, how to revert your patch"
            },
            {   type  => "checkbox",
                name  => "qastatus",
                label => "switch issue status in NetSuite system to QA-cell and add comment about patched sever"
            },
            {   type => "checkbox",
                name => "qacomplete",
                label =>
                  "after positive QA response - update docs/delta.html with release date, patch instructions and issue info in actual hot fix release section"
            },
            {   type  => "checkbox",
                name  => "hotfixcommit",
                label => "commit your changes to release branch including delta docs entry "
            },
        ],
    },
};

sub by_type {
    my $self = shift;
    my $type = shift;
    if ( exists($self->steps->{$type}) ) {
        return($self->steps->{$type});
    }
}

1;
