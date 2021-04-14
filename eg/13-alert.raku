#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup(:1pane);

ui.pane.put("press 'a' for an alert");

ui.bind: a => { ui.alert('alert!!') }

ui.interact;
ui.shutdown;

