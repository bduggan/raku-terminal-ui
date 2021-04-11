#!/usr/bin/env raku

use Terminal::UI 'ui';
use Log::Async;
# ui.log('debug');
ui.setup(:1pane);

ui.pane.put("1. press a key to show a popup");
ui.get-key;

my $f = ui.screen.add-frame(:10height, :40width, :center);
# 10 - 2 borders - 1 divider, leaves 7
my ($r,$p) = $f.add-panes(heights => [1,6]);
$r.put: "title";
$f.draw;
$p.put("I am a popup!");
$p.put("");
$p.put("What is your favorite color?");
$p.put("");
$p.put("");
$p.put("b)lue or g)reen");
ui.focus($f, pane => 1);
$p.select-visible($p.height - 1);
debug "bottom is " ~ $p.height;
my $k = ui.get-key;

ui.screen.remove-frame($f);
ui.focus($f);
ui.refresh;

my %colors = b => 'blue', g => 'green';
ui.pane.put("");
ui.pane.put("2. Done! You chose {%colors{$k} // $k}");
ui.pane.put("");
ui.pane.put("3. press a key again to leave");
ui.get-key;

ui.shutdown;

