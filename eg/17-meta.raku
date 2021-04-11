#!/usr/bin/env raku

use Terminal::UI 'ui';
use Terminal::ANSI;

ui.setup(:1pane);

ui.pane.put: "one", meta => :numero<uno>;
ui.pane.put: "two", meta => :numero<dos>;
ui.pane.put: "three", meta => :numero<tres>;
ui.pane.put: "four", meta => :numero<quatro>;

ui.pane.on: select => -> :%meta ( :$numero ) { ui.alert($numero) }

ui.interact;
ui.shutdown;

