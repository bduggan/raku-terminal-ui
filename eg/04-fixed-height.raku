#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup: heights => [ fr => 1, 5 ];

ui.panes[0].put("The bottom pane has 5 rows.");

ui.panes[1].put($_) for 1..5;

ui.get-key;

ui.shutdown;
