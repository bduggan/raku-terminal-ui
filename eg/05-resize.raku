#!/usr/bin/env raku

use Terminal::UI 'ui';
use Log::Async;

#ui.log('debug');

my $s = ui.add-screen;
my @panes = $s.add-frame.add-panes(ratios => [1, 1]);
my $f = $s.frames[0];
$s.draw;

ui.panes[0].put: "hello";
ui.panes[1].put: "world";

start react whenever $s.resized {
  for @panes -> $b {
    $b.put("height is now " ~ $b.height);
    $b.put("screen height is " ~ $s.rows);
  } 
}

ui.interact;
ui.shutdown;

