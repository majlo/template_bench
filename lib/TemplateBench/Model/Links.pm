package TemplateBench::Model::Links;
use Mojo::Base '-base';

has groups => sub {
    my $groups = [
        {
            title => "OA Instances",
            links => [
                {href => "http://nvolf-work.corp.netledger.com/index.pl?account_nickname=rsi_test;user_nickname=petek;password=petek;_namespace=default", label => "Local"},
                {href => "https://qa.openair1.com/index.pl", label => "QA Trunk"},
                {href => "https://qa.openair1.com:1443/index.pl", label => "QA Release"},
                {href => "https://qa.openair1.com:3443/index.pl", label => "QA UI"},
                {href => "http://www.openair.com/index.pl", label => "Release"},
            ],
        },
        {
            title => "UI",
            links => [
                {href => "https://confluence.corp.netsuite.com/display/TeamOA/OA+UI+Team+Daily+Brief", label => "OA UI Team Daily Brief page"},
                {href => "https://confluence.corp.netsuite.com/pages/viewpage.action?pageId=8232622", label => "OA UI Technicall page"},
                {href => "https://confluence.corp.netsuite.com/display/TeamOA/UI+Graphic+Rules", label => "UI Graphic Rules"},
            ],
        },
        {
            title => "Tech",
            links => [
                {href => "https://confluence.corp.netsuite.com/display/TeamOA/How+to+work+with+central+git+repository+linked+to+CVS", label => "How to work with central git repository linked to CVS"},
                {href => "https://confluence.corp.netsuite.com/display/TeamOA/Ignore+changes+in+GIT+project", label => "Ignore changes in GIT project"},
                {href => "https://confluence.corp.netsuite.com/display/TeamOA/Git+bisect+how+to", label => "How to use bisect"},
                {href => "https://confluence.corp.netsuite.com/display/~nvolf/Grunt", label => "Grunt"},
            ],
        },
        {
            title => "Meetings",
            links => [
                {href => "https://openair.webex.com/openair/j.php?ED=213985432&UID=0&PW=NY2NjNmVhMWEw&RT=MiMxMQ%3D%3D", label => "Daily UI Meeting"},
                {href => "https://netsuite.webex.com/netsuite/j.php?ED=197830422&UID=504046977&PW=NNGNiMTM3ZmI4&RT=MiMyNQ%3D%3D", label => "Weekly UI Meeting"},
            ],
        },
        {
            title => "Tools",
            links => [
                {href => "https://cvs.openair1.com/codestriker", label => "Codestriker"},
                {href => "http://www.netsuite.com/", label => "Netsuite"},
            ],
        },
    ];
    return $groups;
};

1;
