#!/usr/bin/env raku

use Terminal::UI 'ui';
use Terminal::ANSI;

ui.setup(:2panes);
ui.log('/tmp/log');

my $p = ui.panes[0];
my $q = ui.panes[1];

$p.name = 'top';
$q.name = 'bottom';

$p.put: "press a, b, c or d to show an alert";
$p.put: 'or e, which gets the text';
$p.put: 'or f, which has a title';
$p.put: "$_" for 1..5;
$q.put: "pane 2 here";
$p.put: 'a,b only work when pane 1 is focused';
$p.put: '│....|....' x 20;
$p.put: '│         ' x 20;

ui.bind('pane', a => 'alert');
$p.on: alert => { ui.alert('a. pane alert!') }

ui.bind('pane', b => 'notify');
$p.on: notify => { ui.alert('b. ui alert!') }

ui.bind: c => { ui.alert('c. anonymous ui alert!') }
ui.bind: 'pane', d => { ui.alert('d. anonymous pane alert!') }
ui.bind: 'pane', e => -> :$raw { ui.alert("e. got..\n" ~ ($raw.words.join("\n"))) }
ui.bind: f => { ui.alert(:title<hello>, "world") }

ui.interact;
ui.shutdown;

