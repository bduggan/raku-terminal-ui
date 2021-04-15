#!/usr/bin/env raku

use Terminal::UI 'ui';
ui.setup: :2panes;

my (\top,\bottom) = ui.panes;

top.auto-scroll = False;
bottom.auto-scroll = False;
top.exec: <<git log "--pretty=format:%h: %an: %s">>;

top.on: select => -> :$raw {
  my $sha = $raw.split(':')[0];
  bottom.clear;
  bottom.exec: <<git show $sha>>;
}

ui.interact;
ui.shutdown;

