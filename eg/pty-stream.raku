
use Terminal::UI 'ui';

ui.setup(:2panes);
my \top = ui.panes[0];
my \bottom = ui.panes[1];

top.redraw;
top.disable-selection;

top.put: "3";
top.put: "2";
top.put: "1";

my Proc::Async $proc .= new: :pty(:rows(top.height), :cols(top.width)), 'bash';

top.stream: $proc.stdout(:bin);

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

my $p = start ui.interact;

start {
  for 20 ... 0 {
    bottom.put: "$_";
    sleep 0.3;
  }
}

await $p;

ui.shutdown;
