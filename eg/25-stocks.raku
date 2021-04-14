#!/usr/bin/env raku

use Terminal::UI 'ui';
use Terminal::ANSI::OO 't';

ui.setup(:2panes);

start loop {
  sleep 1;
  ui.panes[0].update: line => 1, ' amc ' ~ rand.fmt('%.02f');
  ui.panes[0].update: line => 2, ' gme ' ~ rand.fmt('%.04f') * 100;
  ui.panes[0].update: line => 3, [ t.green => ' nok ' ~ rand.fmt('%.02f')];
}

react whenever ui.keys(:done<q>) { }

ui.shutdown;

