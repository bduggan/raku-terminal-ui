#!/usr/bin/env raku

use Terminal::UI 'ui';
use Terminal::ANSI;

# terminal-ansi-throttle(0.1);

ui.log('debug');
ui.setup(:2panes);

ui.panes[0].put("one");
ui.panes[1].put("two");

ui.panes[0].focus;
#ui.panes[0].select-first-visible;
ui.panes[1].unfocus;
#ui.panes[1].select-first-visible;

ui.panes[0].put("top." ~ $++) for 1..13;
start { ui.panes[1].put("bottom." ~ $++) for 1..23};

ui.interact;

ui.shutdown;
