#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup: heights => [ 10, fr => 1, 10 ];
# help, top, bottom
my (\h, \t, \b) = ui.panes;
h.selectable = False;
b.selectable = False;
b.put: 'output goes here';
h.put: 'type [e] to edit';
h.put: 'type [tab] to stop editing';
h.put: 'type [r] to run';
t.put: 'say "hello"', meta => contents => 'say "hello"';
ui.frame.focus(t);
my $line = b.current-line-index;

ui.bind: 'r' => 'run_code';
ui.on: run_code => {
  my $code = t.lines.join("\n");
  b.clear;
  use MONKEY-SEE-NO-EVAL;
  my $stdout;
  my $stderr;
  {
    my $*OUT = class { method print($a) { $stdout ~= $a } }
    my $*ERR = class { method print($a) { $stderr ~= $a } }
    try EVAL $code;
    if $! {
      b.put: "$_" for "$!".lines;
    }
  }
  b.put: $stdout;
}

ui.bind: 'pane', 'e' => 'edit';
t.on: edit => {
    $line = t.current-line-index;
    my $contents = t.meta[$line]<contents> // "";
    t.update( :$line, "$contents█", meta => :$contents);
    ui.mode = 'input';
}
sub edit-line($c) {
  my \pane := t;
  given $c {
    my $contents = pane.meta[$line]<contents> // '';
    when 'Enter' {
      pane.update( :$line, $contents, meta => %( :$contents ) );
      pane.put("█");
      $line++;
    }
    when 'Delete' {
      if $contents.chars > 0 {
        $contents .= substr(0, $contents.chars - 1) ;
        pane.update( :$line, $contents ~ "█", meta => %( :$contents ) );
      }
    }
    when 'Tab' {
      pane.update( :$line, $contents, meta => %( :$contents ) );
      ui.mode = 'command';
      ui.focus(pane => 0);
    }
    default {
      $contents ~= $c;
      pane.update( :$line, $contents ~ "█", meta => %( :$contents ) );
    }
  }
}

t.on: input => &edit-line;

ui.interact;
ui.shutdown;

