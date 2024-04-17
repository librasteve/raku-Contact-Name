[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)

# Contact::Name 

## Synopsis

This module takes a Str (or an Array of Str) and tries to extract a valid English first name.

It uses two techniques:
1. It matches the start of each Str to a dictionary (based on Scotland 2007 birth registrations).
2. Failing that if takes the text to the left of the first "dot" character such as <[.-_]>.

This seems to work reasonably effectively on a sample of emails.

There is an addendum file (/resources/Extras.csv) with names and short forms that are not present. Please do feel free to propose PRs with any additions to that file - and to for any other features and improvements that you would like.

```perl6
my $n = Name.new;
$n.about;
$n.fail = 'no match';  #default is 'none'

$n.parse( @column[^$limit], :email, :!dotty );

$n.dict.grep: { m:i/$needle/ };
$n.parse: $needle;
```

Options:
- :email ... this tells Contact::Name that it should strip the trailing '@...' when you give it an email address
- :dotty ... this tells Contact::Name to suppress the progress dots


## Script

This module is served up with a side order of the ```ract-name``` script for your convenience. If you want to use that then please note that the script depends on [Net::Google::Sheets](https://github.com/librasteve/raku-Net-Google-Sheets) which in turn depends on [OAuth2::Client::Google](https://github.com/bduggan/p6-oauth2-client-google), so please follow instructions over there to configure your keys and so on.

Absent the script, only ```Text::CSV``` is a pre-requisite.

```
ract-name list
ract-name --sname='reading-c2e-v2' --range='Sheet2' set
ract-name --email=0 -l=5 extract
ract-name --email=0 --first=2 -l=5 convert
ract-name --needle=Joe check


Usage:
  ./ract-name [--sname=<Str>] [--range=<Str>] [--needle=<Str>] [--email[=Int]] [--first[=Int]] [-l[=Real]] [-q] <cmd>
  
    <cmd>             One of set upload clear list get extract convert check
    --sname=<Str>     Active Google Sheet name (from list)
    --range=<Str>     Active Google Sheet range (e.g. 'Sheet2')
    --needle=<Str>    Item to check (e.g. 'Joe')
    --email[=Int]     Column number of emails (input)
    --first[=Int]     Column number of first names (output)
    -l[=Real]         Limit the data processed [default: Inf]
    -q                Quiet mode (suppress cmd echo)
```

### Copyright
copyright(c) 2024 Henley Cloud Consulting Ltd.

