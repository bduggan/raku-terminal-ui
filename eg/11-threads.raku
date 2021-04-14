#!/usr/bin/env raku

use Terminal::UI 'ui';
use Terminal::ANSI;

# terminal-ansi-throttle(0.1);

# ui.log('/tmp/debug');
ui.setup(:2panes);

ui.panes[0].put("one 0");
ui.panes[1].put("two");

ui.panes[0].focus;
#ui.panes[0].select-first-visible;
ui.panes[1].unfocus;
#ui.panes[1].select-first-visible;

await start { ui.panes[0].put("top." ~ $_, :!scroll-ok) for 1..1000; }
await start { ui.panes[1].put("bottom." ~ $_, :!scroll-ok) for 1..1000}

ui.interact;

ui.shutdown;
