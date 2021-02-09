#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup(:1pane);
ui.log('debug');

ui.pane.put: "press a to show an alert";

ui.bind('pane', a => 'alert');
ui.pane.on: alert => { ui.alert('alert!') }

ui.bind(b => 'notify');
ui.on: notify => { ui.alert('notify!') }

ui.bind: c => { ui.alert('hello!') }

ui.interact;
ui.shutdown;

