#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup(ratios => [6,1]);

ui.panes[0].put("Hello world.");

ui.panes[1].put("bottom");

ui.get-key;

ui.shutdown;
