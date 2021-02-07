#!/usr/bin/env raku

use Terminal::UI 'ui';
use Terminal::ANSI::OO :t;

#ui.log('debug');

ui.setup(:2panes);

ui.panes[1].put('hello world');

ui.panes[1].put([t.red => "red", ' ', t.green => "green", ' ', t.blue => "blue"]);

my @rgb = t.red => "red", ' ', t.green => "green", ' ', t.blue => "blue", ' ';
ui.panes[1].put(|@rgb xx 3);
ui.panes[1].put(|@rgb xx 20);

my @row;
for 0..255 {
  @row.push: t.color($_) => $_.fmt("%4d");
  if $_ ∈ ( 15, 51, 87 ... 255 ) {
     ui.panes[0].put(@row);
     @row = Empty;
  }
}
ui.panes[0].put(@row) if @row;

ui.focus(pane => 1);

ui.interact;

ui.shutdown;
