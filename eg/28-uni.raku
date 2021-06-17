#!/usr/bin/raku

use Terminal::UI 'ui';
ui.setup: :2panes;
ui.panes[0].put: 'test' for 1..10;
ui.panes[0].put: '  indent';
ui.panes[0].put: '123' x 100;
ui.panes[0].put: "快餐里的移民往事";
ui.panes[0].put: "快餐里移民往事";
ui.panes[0].put: 'test' for 1..10;
ui.panes[1].put: 'test 2';

ui.interact;
ui.shutdown;

