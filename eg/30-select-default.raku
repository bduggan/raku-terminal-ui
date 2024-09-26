#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup(:1panes);

ui.frame.pane.put: 'press s to select';

ui.bind: s => { ui.alert("choose a color", values => <green blue red orange>, default-row => 0) }
ui.bind: t => { ui.alert("choose a color", values => <green blue red orange>, default-row => 1) }

ui.interact;
ui.shutdown;

