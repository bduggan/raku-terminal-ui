#!/usr/bin/env raku

use Terminal::UI 'ui';

my $pane := ui.add-screen.add-frame.add-pane;

$pane.put("type keys please:");

loop {
  my $k = ui.get-key;
  $pane.put($k.raku); 
  last if $k eq 'q';
}
ui.shutdown;

