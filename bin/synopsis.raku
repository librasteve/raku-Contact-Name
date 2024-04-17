#!/usr/bin/env raku

use Text::CSV;
use JSON::Fast;
use Net::Google::Sheets;
use Contact::Name;

my @goals = <upload clear list get extract convert check>;
my $goal = @goals[2];
my $limit = 10;

my $name = 'reading-c2e-v2';
my $range = 'Sheet2';
my $email = 0;
my $first = 2;

my $session = Session.new;
#$session.check-token;
my %list = $session.sheets;
my $id = %list{$name};

my $sheet = Sheet.new(:$session, :$id, :$range);

sub extract( @values ) {

    my @column = @values[*;$email];
    @column.shift;

    my $n = Name.new;
    $n.parse( @column[^$limit], :email );
}

given $goal {

    when 'list' {
        %list.keys.sort.map(*.say);
    }

    when 'upload' {
        my $in = "$*HOME/Downloads/$name.csv";

        my @data = csv(:$in).Array;
        $sheet.values: @data;
    }

    when 'clear' {
        $sheet.clear;
    }

    when 'get' {
        $sheet.values.head(5).say;
    }

    when 'extract' {
        my @data = $sheet.values;
        @data.&extract.say;
    }

    when 'convert' {
        my @data = $sheet.values;

        my $old-hdr = @data[0;$first];
        @data[*;$first] = [$old-hdr, |@data.&extract];

        $sheet.values: @data;
    }

    when 'check' {
        my $needle = 'nuno';
        my $n = Name.new;
        say $n.dict.grep: { m:i/$needle/ };
        say $n.parse: $needle;
    }
}





