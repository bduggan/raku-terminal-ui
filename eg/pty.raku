
use Terminal::UI 'ui';
use Terminal::ANSIParser;

ui.setup(:2panes);
my \top = ui.panes[0];
my \bottom = ui.panes[1];
my Proc::Async $proc .= new: :pty(:rows(top.height), :cols(top.width)), 'bash';
my $receive = $proc.stdout(:bin);

my $log = open '/tmp/pty-debug.log', :w;

my &parse := make-ansi-parser(emit-item => -> $item {
   if $item ~~ Terminal::ANSIParser::CSI {
      my $bytes = $item.sequence.list.fmt('%02x', ' ');
      $log.say("CSI: " ~ $bytes ~ " | Str: " ~ $item.Str.raku);
      top.print($item.Str);
   } elsif $item ~~ Terminal::ANSIParser::Sequence {
      $log.say($item.^name ~ ": " ~ $item.sequence.list.fmt('%02x', ' '));
      top.print($item.Str);
   } elsif $item ~~ Int {
      $log.say("Char: " ~ chr($item).raku ~ " (" ~ $item.fmt('%02x') ~ ")");
      top.print(chr($item));
   } else {
      $log.say("Unknown: " ~ $item.^name ~ " | " ~ $item.raku);
   }
   $log.flush;
});

$receive.tap: -> $bytes {
   parse($_) for $bytes.decode.ords;
}

react {
  whenever $proc.ready {
    $proc.put("ls -l");
    sleep 1;
    $proc.put("seq 100");
    sleep 1;
    $proc.put("sleep 1");
    sleep 2;
    $proc.put("exit");
    sleep 1;
  }
  whenever $proc.start {
    top.put: "done";
  }
}

sleep 5;
$log.close;
ui.shutdown;
