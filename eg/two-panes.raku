#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup(:2panes);

ui.panes[0].put("Hello world.");

ui.panes[1].put("press any key");

ui.get-key;

ui.shutdown;

