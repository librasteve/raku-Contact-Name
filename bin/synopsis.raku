#!/usr/bin/env raku

use Text::CSV;
use JSON::Fast;
use Data::Dump::Tree;
use Net::Google::Sheets;
use Contact::Name;

my $limit = Inf;

my $name = 'reading-c2e-v2';
my $range = 'Sheet2';
my $email = 0;
my $first = 2;

my @goals = <upload clear list get extract convert check>;
my $goal = @goals[5];

my $session = Session.new;
#$session.check-token;
my %list = $session.sheets;
my $id = %list{$name};

my $active = Sheet.new(:$session, :$id, :$range );

sub extract( @values ) {

    my @data = @values[*;$email];

    for @data[1..*] -> $datum is rw {
        $datum ~~ s:g/'(' .* ')'//;             #rm anything in parens
        $datum ~~ s:g/^ (.*?) '@' .* $/$0/;     #take lhs of email address
    }

    my $n = Name.new;
    $n.parse: @data[1..^$limit];

    # some test ideas
    #        say $n.about;
    #        say +$n.dict;
    #        say $n.parse: 'Joel';
    #        say $n.parse: 'Ann';
    #        say $n.parse: 'Rob.toms';
    #        say $n.parse: 'John-Paul';
    #        say $n.parse: ['xxx', 'Ann'];
    #        say $n.dict;
}

my @values;

given $goal {
    when 'list' {
        %list.keys.sort.map(*.say);
    }
    when 'upload' {
        my $in = "$*HOME/Downloads/$name.csv";

        my @data = csv(:$in).Array;
        $active.values: @data;
    }
    when 'clear' {
        $active.clear;
    }
    when 'get' {
        @values = $active.values;
    }
    when 'extract' {
        my @data = $active.values;
        @data.&extract.say;
    }
    when 'convert' {
        my @data = $active.values;

        my $old-hdr = @data[0;$first];
        @data[*;$first] = [$old-hdr, |@data.&extract];

        $active.values: @data;
    }
    when 'check' {
        my $n = Name.new;
        say $n.dict.grep: { m:i/^i/ };
        say $n.parse: 'ifno';
    }
}





