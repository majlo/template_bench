package TemplateBench::Benchmark;
use Mojo::Base 'Mojolicious::Controller';

my $message = 'Welcome to the Mojolicious real-time web framework!';

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render( message => 'Welcome to the Mojolicious real-time web framework!');
}

sub mojotemplate {
  my $self = shift;
  return $self->render( message => $message );
}

sub templatetoolkit {
  my $self = shift;
  $self->render( message => $message );
}

sub xslate {
  my $self = shift;
  $self->render( message => $message );
}

sub mason {
  my $self = shift;
  $self->render('/index', handler => "mason", message => $message);
}

sub htp {
  my $self = shift;
  $self->render( message => $message );
}

1;
