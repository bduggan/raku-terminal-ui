
use Terminal::UI 'ui';
use Terminal::ANSIParser;

ui.log('/tmp/ui-debug.log');
ui.setup(:2panes);
my \top = ui.panes[0];
my \btm = ui.panes[1];
top.disable-selection;
top.redraw;

my Proc::Async $proc .= new: :pty(:rows(top.height), :cols(top.width)), 'bash';
my $receive = $proc.stdout(:bin);

my &parse := make-ansi-parser(emit-item => -> $item {
   if $item ~~ Terminal::ANSIParser::CSI {
      my $bytes = $item.sequence.list.fmt('%02x', ' ');
      top.print($item.Str);
   } elsif $item ~~ Terminal::ANSIParser::Sequence {
      top.print($item.Str);
   } elsif $item ~~ Int {
      top.print(chr($item));
   } else {
      btm.put("Unknown: " ~ $item.^name ~ " | " ~ $item.raku);
   }
});

$receive.tap: -> $bytes {
   parse($_) for $bytes.decode.ords;
}
start react {
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
    top.enable-selection;
  }
}
for 40 ... 0 {
  btm.put: "$_";
  sleep 0.3;
}
ui.interact;
ui.shutdown;
