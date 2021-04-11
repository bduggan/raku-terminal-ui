#!/usr/bin/env raku

use Terminal::UI 'ui';

# ui.log('/tmp/debug');
ui.setup(ratios => [1,1]);

my $mojo = run <<mojo get https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml 'item > title,link' text >>, :out;

for $mojo.out.lines -> $text, $value {
   ui.panes[1].put("$text", meta => url => ~$value, :!scroll-ok );
}

sub show-article($url) {
  my $proc = run <<w3m -dump $url>>, :out;
  ui.panes[0].clear;
  ui.panes[0].put($url);
  start react whenever $proc.out.lines -> $l {
    ui.panes[0].put($l, :!scroll-ok)
  }
}

ui.panes[0].put("select an article");

ui.panes[1].on(
  select => -> :$raw, :$meta {
    show-article($meta<url>)
  }
);

ui.panes[0].on(
  select => -> :$raw, :$meta {
    shell "open $raw" if $raw ~~ /^^ http/;
  }
);

ui.interact;

ui.shutdown;
