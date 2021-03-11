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
$p.put: 'or h, which sends an array';
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
ui.bind: g => { ui.alert(:title<hello>, <this is four lines>) }

$p.put: "i returns a value";
ui.bind: i => { $p.put: ui.alert(:title<returning>, <one two three>) }

$p.put: "s or t select from a list";
ui.bind: s => { $p.put: ui.alert("choose a color", values => <green blue red orange>) }
ui.bind: t => { $p.put: ui.select("choose a color", <green blue red orange>) }

$q.put: 'select in the frame will do an alert';
$q.on: select => { ui.alert('hi') };

ui.interact;
ui.shutdown;

