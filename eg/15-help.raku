#!/usr/bin/env raku

use Terminal::UI 'ui';
use Terminal::ANSI;

ui.setup(:2panes);
# ui.log('/tmp/log');

my $p = ui.panes[0];
my $q = ui.panes[1];

$p.name = 'top';
$q.name = 'bottom';

$p.put: 'h for help';

ui.bind('pane', a => 'alert');
$p.on: alert => { ui.alert('a. pane alert!') }

ui.bind('pane', b => 'notify');
$p.on: notify => { ui.alert('b. ui alert!') }

ui.bind: c => { ui.alert('c. anonymous ui alert!') }

ui.interact;
ui.shutdown;

