#!/usr/bin/env raku

use Terminal::UI 'ui';
use Log::Async;

#ui.log('debug');

my $s = ui.add-screen;
my @panes = $s.add-frame.add-panes(ratios => [1, 1]);
my $f = $s.frames[0];
$s.draw;

start react whenever $s.resized {
  for @panes -> $b {
    $b.put("height is now " ~ $b.height);
    $b.put("screen height is " ~ $s.rows);
  } 
}

loop {
  my $k = ui.get-key;
  last if $k eq 'q';
  $s.draw if $k eq 'r';
}

ui.shutdown;

