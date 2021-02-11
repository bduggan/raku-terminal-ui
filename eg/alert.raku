#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup(:1pane);
# ui.log('debug');

ui.pane.put: "press a, b, c or d to show an alert";
ui.pane.put: 'or e, which gets the text';
ui.pane.put: 'or f, which has a title';
ui.pane.put: "$_" for 1..5;

ui.bind('pane', a => 'alert');
ui.pane.on: alert => { ui.alert('a. pane alert!') }

ui.bind(b => 'notify');
ui.on: notify => { ui.alert('b. ui alert!') }

ui.bind: c => { ui.alert('c. anonymous ui alert!') }

ui.bind: 'pane', d => { ui.alert('d. anonymous pane alert!') }

ui.bind: 'pane', e => -> :$raw { ui.alert("e. got..\n" ~ ($raw.words.join("\n"))) }

ui.bind: f => { ui.alert(:title<hello>, "world") }

ui.interact;
ui.shutdown;

