#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup: heights => [ fr => 1, 10 ];
my (\t,\b) = ui.panes;
t.put: 'output goes here';
t.put: 'type [tab] to switch';
t.put: 'type [tab] to stop editing';
b.put: 'say "hello"', meta => contents => 'say "hello"';
my $line = b.current-line-index;

ui.bind: 'pane', 'e' => 'edit';
b.on: edit => {
    $line = b.current-line-index;
    my $contents = b.meta[$line]<contents> // "";
    b.update( :$line, "$contents█", meta => :$contents);
    ui.mode = 'input';
}
sub edit-line($c) {
    given $c {
      my $contents = b.meta[$line]<contents>;
      when 'Enter' {
        b.update( :$line, $contents, meta => %( :$contents ) );
        b.put("█");
        $line++;
      }
      when 'Delete' {
        if $contents.chars > 0 {
          $contents .= substr(0, $contents.chars - 1) ;
          b.update( :$line, $contents ~ "█", meta => %( :$contents ) );
        }
      }
      when 'Tab' {
        b.update( :$line, $contents, meta => %( :$contents ) );
        ui.mode = 'command';
        ui.focus(pane => 0);
      }
      default {
        $contents ~= $c;
        b.update( :$line, $contents ~ "█", meta => %( :$contents ) );
      }
    }
}

b.on: input => &edit-line;

ui.interact;
ui.shutdown;

