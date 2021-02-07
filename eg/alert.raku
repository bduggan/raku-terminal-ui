#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup(:1pane);

ui.pane.put: "press a to show an alert";

ui.pane.on: alert => -> :$raw, :$meta {
  ui.alert("1234567890");
}

ui.bind('pane', a => 'alert');

ui.interact;

ui.shutdown;

