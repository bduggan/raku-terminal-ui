#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.log('/tmp/log');
ui.setup(:2panes);

ui.panes[0].put("$_", :!scroll-ok) for 1..100;
ui.panes[1].put("$_", :!scroll-ok) for 1..100;

ui.interact;
ui.shutdown;

