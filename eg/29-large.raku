#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.log('log');
ui.setup(:1pane);

ui.pane.put("hi " ~ ++$) :!scroll-ok for 1..1000;

ui.interact;
ui.shutdown;

