
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

my $buffer = '';

sub flush-buffer {
   if $buffer {
      top.print($buffer);
      $buffer = '';
   }
}

my &parse := make-ansi-parser(emit-item => -> $item {
   if $item ~~ Terminal::ANSIParser::CSI {
      flush-buffer();
      top.print($item.Str);
   } elsif $item ~~ Terminal::ANSIParser::Sequence {
      flush-buffer();
      top.print($item.Str);
   } elsif $item ~~ Int {
      my $char = chr($item);
      # Flush on newline or carriage return
      if $char eq "\n" || $char eq "\r" {
         flush-buffer();
         top.print($char);
      } else {
         # Buffer regular characters
         $buffer ~= $char;
      }
   } else {
      flush-buffer();
      btm.put("Unknown: " ~ $item.^name ~ " | " ~ $item.raku);
   }
});

$receive.tap: -> $bytes {
   parse($_) for $bytes.decode.ords;
   flush-buffer();  # Flush at end of each batch
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
