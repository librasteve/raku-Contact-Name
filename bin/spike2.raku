my @dict =
    <Theo Tomas Irvine Graeme Toby Olivier Brayden Coll Caiden Brody Fraser Tom Jack Callan Adam Kade Iain Jaden Nairn Alexander Jai Graham Charlie Jenson Kaleb Zain Shay Cole Riley Evan Matt Ramsay Deacon Caelan Hubert Douglas Ryan Cayden Frazer Mason Grant Joel Brian Yusuf Frankie Hassan Brandyn Lawson Paul Ben Dominik Patrick Mathew Sol Edward Harry Abdullah Alan Jayson Maximilian Hayden Freddie Keigan Adrian Torin Kaden Greig Jude Samuel Ryley Tristan Layton Joey Brooklyn Charles Luka Myles Rudy Max Bryan Milo Haydn Joshua Robin Struan Campbell Zak Reece Jonathon Ruaridh Ashton Daryl Travis Ian Matthew Ritchie Piotr Aleksander Shaun Zane>;

say +@dict;


#say $n.parse: 'Joe';
#say $n.parse: 'Ann';
#say $n.parse: 'Rob.toms';
#say ($n.parse: 'John-Paul').grep: /'-'/;
say @dict.grep: /Mat/;

my $d := @dict;

my $s = 'Matthew.Jones';

dd $s ~~ /$d/;
say ($s ~~ m:i/@dict/).Str;

