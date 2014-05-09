use Mojolicious::Lite;

get '/' => sub {
    my $self = shift;
    $self->render(text => sprintf('Powered by %s', $ENV{'POWERED_BY'} || 'Deis'));
};

app->start;
