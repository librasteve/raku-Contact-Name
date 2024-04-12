use LLM::Functions;
use LLM::Prompts;
use Text::SubParsers;
use JSON::Fast;
use Data::Dump::Tree;
use Text::CSV;
use Net::Google::Sheets;

my $name = 'reading-c2e-v2';
my $email = 'Email';
my $full = 'Full name';
my $first = 'First name';
my $last = 'Last name';

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

        my @data = @values[*;%col{$email}][1..*];

        for @data -> $datum is rw {
            $datum ~~ s:g/'(' .* ')'//;       #rm anything in parens
            $datum ~~ s:g/^ (.*?) '@' .* $/$0/;     #take lhs fo email
        }


        say @data;


    }
}





