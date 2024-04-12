use Text::CSV;
use JSON::Fast;
use Data::Dump::Tree;
use Net::Google::Sheets;
use Contact::Name;

my $name = 'reading-c2e-v2';

#my $goal = 'upload';
#my $goal = 'clear';
#my $goal = 'list';
#my $goal = 'get';
my $goal = 'extract';

my $live = 'sheet2';

my $session = Session.new;
#$session.check-token;
my %list = $session.sheets;
my $id = %list{$name};

my %active = (
    sheet1 => Sheet.new(:$session, :$id, range => 'Sheet1'),
    sheet2 => Sheet.new(:$session, :$id, range => 'Sheet2'),
    sheet3 => Sheet.new(:$session, :$id, range => 'Sheet3'),
);

my @values;

given $goal {
    when 'list' {
        %list.keys.sort.map(*.say);
    }
    when 'upload' {
        my $in = "$*HOME/Downloads/$name.csv";

        my @dta = csv(:$in).Array;
        %active{$live}.values: @dta;
    }
    when 'clear' {
        %active{$live}.clear;
    }
    when 'get' {
        @values = %active{$live}.values;
    }
    when 'extract' {
        @values = %active{$live}.values;

        my %col = @values[0;*] Z=> ^Inf;

        my $num;
        for %col.kv -> $key, $val { $num = $val if $key ~~ m:i/email/ }

        my @data = @values[*;$num];
        @data .= splice(1);

        for @data -> $datum is rw {
            $datum ~~ s:g/'(' .* ')'//;             #rm anything in parens
            $datum ~~ s:g/^ (.*?) '@' .* $/$0/;     #take lhs of email address
        }

        my $n = Name.new;


        say +@data;

        my @res = $n.parse: @data.head(20);
        say @res;
        say +@res;

#        say $n.about;
#        say +$n.dict;
#        say $n.parse: 'Joel';
#        say $n.parse: 'Ann';
#        say $n.parse: 'Rob.toms';
#        say $n.parse: 'John-Paul';
#        say $n.parse: ['xxx', 'Ann'];
#        say $n.dict;


    }
}





