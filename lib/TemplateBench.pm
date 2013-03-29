package TemplateBench;
use Mojo::Base 'Mojolicious';
use MojoX::Renderer::HTP;
use MojoX::Renderer::Xslate;

# This method will run once at server start
sub startup {
    my $self = shift;

    # Documentation browser under "/perldoc"
    $self->plugin('PODRenderer');
    $self->plugin('mason1_renderer');
    $self->plugin(tt_renderer => {template_options => {}});

    my $xslate = MojoX::Renderer::Xslate->build(
        mojo             => $self,
        template_options => { },
    );
    $self->renderer->add_handler(tx => $xslate);

    my $pro = MojoX::Renderer::HTP->build(
        mojo             => $self,
        template_options => {path => [$self->home->rel_dir('templates')],}
    );
    $self->renderer->add_handler(pro => $pro);

    # Router
    my $r = $self->routes;
    $r = $r->route('/template-bench');

    # Normal route to controller
    $r->get('/')->to('benchmark#welcome');
    $r->get('/ep')->name('ep')->to('benchmark#mojotemplate'); #Mojo::Template
    $r->get('/tt')->name('tt')->to('benchmark#templatetoolkit'); #Template::Toolkit
    $r->get('/tx')->name('tx')->to('benchmark#xslate'); #Text::Xslate
    $r->get('/mo')->name('mo')->to('benchmark#mason'); #HTML::Mason
    $r->get('/ht')->name('ht')->to('benchmark#htp'); #HTML::Template::Pro
}

sub development_mode {
    shift->log->path(undef);
}

1;
