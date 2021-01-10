#!/usr/bin/env raku

use Terminal::UI 'ui';
use Log::Async;

# ui.log("debug");

my $screen = ui.add-screen;
my $frame =
   $screen.add-frame(
   :top(7), :height(20), :left(5), :width(50));

my ($pane1,$pane2) = $frame.add-panes(heights => <9 8>);

$frame.draw;

my $p1 = start $pane1.put("upper $_") for 1..115;
my $p2 = start $pane2.put("lower $_") for 1..115;

await Promise.allof([$p1,$p2]);

my $focused = $frame.focus($pane1);
$pane1.select($pane1.first-visible);

loop {
  $_ = ui.get-key;
  $focused.select-up when 'k';
  $focused.select-down when "j";
  when "\t" {
    $focused = $focused === $pane1 ?? $pane2 !! $pane1;
    $frame.focus($focused);
  }
  last when 'q';
}

ui.shutdown;
