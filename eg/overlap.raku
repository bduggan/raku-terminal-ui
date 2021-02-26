#!/usr/bin/env raku

use Terminal::UI 'ui';

my $screen = ui.add-screen;

my $big = $screen.add-frame(:top(7), :height(20), :left(5), :width(50), :name<big>);
my ($pane1,$pane2) = $big.add-panes(heights => <9 8>);

my $little = $screen.add-frame(:top(4), :height(5), :left(60), :width(10), :name<little>);
my ($pane3) = $little.add-panes(heights => <3>);

$big.draw;
$little.draw;

$pane1.put("upper $_") for 1..10;
$pane2.put("lower $_") for 1..3;
$pane2.put("m)oo c)ow");

ui.find-frame('big').panes[0].select-visible(0);

ui.focus(:frame<big>, pane => 0);

$pane3.put($_) for <how now brown>;

my $pane = 0;

loop {
  $_ = ui.get-key;
  ui.focused.select-up when 'k';
  ui.focused.select-down when "j";
  when "Tab" {
    $pane++;
    $pane %= 2;
    ui.focus(:frame<big>, :$pane);
  }
  $pane3.put("COW") when "c";
  $pane3.put("moo") when "m";
  last when 'q';
}

ui.shutdown;
