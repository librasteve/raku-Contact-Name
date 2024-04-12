use Text::CSV;

class Name {
    my $ract = '.ract-config';
    my $file = 'Scotland-2007.csv';

    has @.data;
    has Bag $.boys;
    has Bag $.girls;

    has @.dict;
    has $.about;

    submethod TWEAK {
        my @all = csv(in => "$*HOME/$ract/$file");
        @!data  = @all.splice(4);
        $!about = @all.first;

        $!boys  = (@!data[*;0] Z=> @!data[*;1]).Bag;
        $!girls = (@!data[*;3] Z=> @!data[*;4]).Bag;

        @!dict = (
            |$!boys.keys,
            |$!girls.keys,
        ).map: { .subst( /'-'/, "\-" ) }
    }

    multi method parse(Str $s) {
        my @dict := @!dict;
        my $res = $s ~~ m:i/^@dict/;

        $res ?? ~$res.tc !! 'none'
    }

    multi method parse(@a) {
        @a.map: { samewith($_) }
    }
}

