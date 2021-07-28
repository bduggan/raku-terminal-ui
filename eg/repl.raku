#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup: heights => [ fr => 1, 10 ];
my (\t,\b) = ui.panes;
t.put: 'say "hello"';
b.put: 'e) to edit>', meta => :new;
my $line = b.current-line-index;

ui.bind: 'pane', 'e' => 'edit';
b.on: edit => {
    $line = b.current-line-index;
    my $contents = b.meta[$line]<new> ?? "" !! b.meta[$line]<contents> // "";
    b.update( :$line, "$contents█", meta => :$contents);
    ui.mode = 'input';
}
sub edit-line($c) {
    given $c {
      my $contents = b.meta[$line]<contents>;
      when 'Enter' {
        b.update( :$line, $contents, meta => %( :!new, :$contents ) );
        b.put("█", meta => :new );
        $line++;
      }
      when 'Delete' {
        if $contents.chars > 0 {
          $contents .= substr(0, $contents.chars - 1) ;
          b.update( :$line, $contents ~ "█", meta => %( :!new, :$contents ) );
        }
      }
      when 'Tab' {
        b.update( :$line, $contents, meta => %( :!new, :$contents ) );
        ui.mode = 'command';
        ui.focus(pane => 0);
      }
      default {
        $contents ~= $c;
        b.update( :$line, $contents ~ "█", meta => %( :!new, :$contents ) );
      }
    }
}

b.on: input => &edit-line;

ui.interact;
ui.shutdown;

