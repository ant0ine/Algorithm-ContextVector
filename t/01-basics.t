#!perl -T

use Test::More tests => 6;

use Algorithm::ContextVector;

sub near {
    my ($value, $test) = @_;
    my $e = 0.0001;
    ok( abs( $value - $test ) < $e, "$value near $test");
}

note 'independant';
{
    my $cv = Algorithm::ContextVector->new;
    isa_ok $cv, 'Algorithm::ContextVector';

    $cv->add_instance( label => 'a', attributes => { aaa => 3, aa => 2 } );
    $cv->train;

    my $result = $cv->predict( attributes => { bbb => 1, bb => 4 } );
    isa_ok $result, 'HASH';

    is_deeply $result, { a => 0 }, 'result';
}

note 'similar';
{
    my $cv = Algorithm::ContextVector->new;
    isa_ok $cv, 'Algorithm::ContextVector';

    $cv->add_instance( label => 'a', attributes => { aaa => 2, aa => 2 } );
    $cv->train;

    my $result = $cv->predict( attributes => { aaa => 1, aa => 1 } );
    isa_ok $result, 'HASH';

    is_deeply $result, { a => 1 }, 'result';

}

