#!/usr/bin/env raku

use Terminal::UI 'ui';
use Terminal::ANSI;

# ui.log('/tmp/debug');

my $screen = ui.add-screen;
my $frame = $screen.add-frame;
my $pane = $frame.add-pane;

$frame.draw;
$pane.focus;

$pane.put("top");
for 1..72 {
 $pane.put("hello " ~ ++$);
}

$pane.put("hello again " ~ ++$) for 1..23;

$pane.put("press j and k to scroll up and down");

$pane.select-visible(5);

loop {
  $_ = ui.get-key(:decode);
  $pane.scroll-up when 'k';
  $pane.scroll-up(:5lines) when 'K';
  $pane.scroll-down when "j";
  $pane.scroll-down(:5lines) when 'J';
  last when 'q';
}

ui.shutdown;
