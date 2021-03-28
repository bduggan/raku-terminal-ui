#!/usr/bin/env raku

use Terminal::UI 'ui';
use Terminal::ANSI::OO 't';

ui.setup(:2panes);

my @rgb = t.red => "red", ' ', t.green => "green", ' ', t.blue => "blue", ' ';
ui.panes[1].put(@rgb);
ui.panes[1].put(|@rgb xx 3);
ui.panes[1].put(|@rgb xx 20);

my @row;

for 0..255 {
  @row.push: t.color($_) => .fmt("%4d");
  if $_ ∈ ( 15, 51, 87 ... 255 ) {
     ui.panes[0].put(@row);
     @row = Empty;
  }
}

ui.panes[0].put(@row) if @row;

ui.panes[0].put: [ t.bg-color(0) ~ t.color(3)  => 'bg color' ];
ui.panes[0].put: [ t.bg-color(4) ~ t.color(1)  => 'bg color' ];
ui.panes[0].put: [ t.color(4) => 'no bg color' ];
ui.panes[0].put: [ t.color(4) => 'no bg color' ];
ui.panes[0].put: [ t.color(4) => 'no bg color' ];

ui.interact;

ui.shutdown;
