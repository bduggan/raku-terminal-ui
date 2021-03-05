#!/usr/bin/env raku

use Terminal::UI 'ui';
use Terminal::ANSI;

ui.setup(:1pane);

ui.pane.put: "press return", meta => :hello<world>;

#ui.pane.on: select => -> :$meta { ui.alert($meta.raku) }

ui.pane.on: select => -> :%meta ( :$hello ) { ui.alert($hello) }

ui.interact;
ui.shutdown;

