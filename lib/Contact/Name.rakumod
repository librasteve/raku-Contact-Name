use Text::CSV;

class Name {
    my $ract   = '.ract-config';
    my $main   = 'Scotland-2007.csv';
    my $extras = 'Extras.csv';

    my @dict;      #need a lexical cp for regex interpolation

    has @.data;
    has Bag $.boys;
    has Bag $.girls;

    has @.dict;
    has $.about;
    has $.fail = 'none';

    submethod TWEAK {
        my @main = csv(in => "$*HOME/$ract/$main");
        @!data  = @main.splice(4);
        $!about = @main.first;

        $!boys  = (@!data[*;0] Z=> @!data[*;1]).Bag;
        $!girls = (@!data[*;3] Z=> @!data[*;4]).Bag;

        @!dict = (
            |$!boys.keys,
            |$!girls.keys,
        ).map: { .subst( /'-'/, "\-" ) }

        @!dict.append: csv(in => "$*HOME/$ract/$extras");

        @dict := @!dict;
    }

    multi method parse( Str() $str, :$dotty ) {

        #| get lhs of any "dot" char, such as <[.-_]>
        sub try-dot( $str ) {
            if $str ~~ /(.+?) <[.-]>/ {
                if $0.chars >= 3 {
                    $0.tclc;
                }
            }
        }

        my Str() $res;
        print '.' if $dotty;

        #| guards with early exit
        given $str {
            when .chars < 3 {
                return $.fail;
            }
            default {
                $res = $str ~~ m:i/^@dict/;
            }
        }

        #| last chance fix with try-dot
        given $res {
            when .chars < 3 {
                $str.&try-dot // $.fail;
            }
            when 'False' {   #we have coerced False to Str
                $str.&try-dot // $.fail;
            }
            default {
                $res.tclc;
            }
        }
    }

    multi method parse( @a, :$dotty = True ) {

        @a.map: { samewith($_, :$dotty) }
    }

    multi method parse( @a, :$email! where .so, :$dotty = True ) {

        my @b = @a.map: { /(.+?) \@/; $0 };

        @b.map: { samewith($_, :$dotty) }
    }
}

