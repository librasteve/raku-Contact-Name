[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)

# Contact::Name 

## Synopsis

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

