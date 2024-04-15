use Text::CSV;

class Name {
    my $ract = '.ract-config';
    my $file = 'Scotland-2007.csv';

    my @dict;

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

        @dict = @!dict;
    }

    multi method parse(Str $str) {
        #iamerejh ... if none, look for xxx.yyy, xxx-yyy pattern instead
        return 'none' if $str.chars < 3;

        my $res = $str ~~ m:i/^@dict/;

        return 'none' if $res.chars < 3;

        $res ?? ~$res.tclc !! 'none'
    }

    multi method parse(@a) {
        @a.map: { samewith($_) }
    }
}

