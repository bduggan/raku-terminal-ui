#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup: :2panes;

start {
  ui.panes[0].put: $_, :meta(word => $_), :!scroll-ok for "/usr/share/dict/words".IO.lines;
}

ui.panes[0].on: select => -> :%meta {
  my $word = %meta<word>;

  ui.panes[1].clear;
  ui.panes[1].put: $word;

  my $p = run <<dict $word>>, :out, :err;
  start react whenever $p.out.lines -> $l {
    ui.panes[1].put: $l, :!scroll-ok;
  }
}

ui.interact;
ui.shutdown;
