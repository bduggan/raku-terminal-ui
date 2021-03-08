#!/usr/bin/env raku

use Terminal::UI 'ui';
use Terminal::ANSI::OO :t;

ui.setup: :2panes;
ui.panes[0].put: "welcome!";
ui.get-key;

show-dir($*CWD);

sub show-dir($dir) {
  my \p = ui.panes[0];
  p.clear;
  p.put: [t.yellow => "$dir"];
  p.put: [t.magenta => ".. (up)"], :meta( dir => $dir.parent );

  for $dir.dir.sort({!.d,.fc}) {
    next if .basename.starts-with('.');
    p.put: [t.cyan => .basename ~ '/'], :meta(:dir($_)), :!scroll-ok when .d;
    p.put: .basename, :meta(:file($_)), :!scroll-ok when .f;
  }
  p.select-first;
}

sub show-file($file) {
  my \p = ui.panes[1];
  p.clear;
  start p.put: $file, :!scroll-ok 
}

ui.panes[0].on: select => -> :%meta { 
  show-dir($_) with %meta<dir>;
  show-file($_) with %meta<file>;
}

ui.bind: 'pane', i => 'info';
ui.panes[0].on: info => -> :%meta ( :$file, :$dir ) {
  ui.alert([$file.basename, "Last modified: { $file.modified.DateTime }"])
    with $file;
}

ui.interact;
ui.shutdown;

