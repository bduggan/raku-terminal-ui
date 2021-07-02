#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.log('/tmp/out');

ui.setup: heights => [ fr => 1, 10 ];
my (\t,\b) = ui.panes;
t.put: 'say "hello"';
b.put: 'e) to edit>', meta => :new;
my $line = b.current-line-index;

ui.bind: 'pane', 'e' => 'type';
b.on: type => {
    b.update( :$line, "█", meta => :new);
    ui.mode = 'input';
}
b.on: input => -> $c {
    given $c {
      my $contents = b.meta[$line]<new>  ?? "" !! (b.meta[$line]<contents> || b.raw[$line]);
      when 'Enter' {
        b.update( :$line, $contents, meta => %( :!new, :$contents ) );
        b.put("█", meta => :new );
        $line++;
      }
      when 'Delete' {
        $contents = $contents.substr(0, $contents.chars - 1) if $contents.chars > 0;
        b.update( :$line, $contents ~ "█", meta => %( :!new, :$contents ) );
      }
      default {
        $contents ~= $c;
        b.update( :$line, $contents ~ "█", meta => %( :!new, :$contents ) );
      }
    }
}

ui.interact;
ui.shutdown;

