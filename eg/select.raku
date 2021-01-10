#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.add-screen
  .add-frame(:top(7), :height(9), :left(5), :width(50))
  .add-pane;

ui.draw;

ui.pane.focus;

for 0..97 {
 ui.pane.put("line $_, starting row { $_ + 1 }");
}

ui.pane.select-visible(2);

react whenever ui.keys(done => 'q') {
  ui.pane.select-up when 'k';
  ui.pane.select-down when 'j';
}

ui.shutdown;
