#!/usr/bin/raku

use Terminal::UI 'ui';
use Terminal::ANSI::OO 't';

ui.setup: :2panes;
ui.panes[0].put: 'test' for 1..10;
ui.panes[0].put: '  indent';
ui.panes[0].put: '123' x 100;
ui.panes[0].put: "快餐里的移民往事";
ui.panes[0].put: "快餐里移民往事";
ui.panes[0].put: 'test' for 1..10;
ui.panes[1].put: 'test 2';
ui.panes[1].put: [ t.bg-red ~ t.bright-white => 'test 2' ];
ui.panes[1].put: [ t.bg-red ~ t.bright-white => 'spaces', t.bg-red ~ t.white => '_    ->   ' ];
ui.panes[1].put: [ t.bg-blue => "  " x ui.panes[1].width ];
ui.panes[1].auto-scroll = False;
ui.panes[1].put: $++ for 1..100;

ui.interact;
ui.shutdown;

