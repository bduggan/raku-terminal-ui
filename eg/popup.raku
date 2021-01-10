#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup(:1pane);

ui.pane.put("1. press a key to show a popup");
ui.get-key;

my $f = ui.screen.add-frame(:10height, :40width, :center);
my $p = $f.add-pane;

$p.put("I am a popup!");
$p.put("");
$p.put("What is your favorite color?");
$p.put("b)lue or g)reen");
ui.focus($f);
$p.select(3);
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

