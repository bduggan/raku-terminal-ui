
use Terminal::UI 'ui';

ui.setup(:2panes);
my \top = ui.panes[0];
my \bottom = ui.panes[1];
top.disable-selection;
top.redraw;

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

start {
  for 20 ... 0 {
    bottom.put: "$_";
    sleep 0.3;
  }
}

ui.interact;
ui.shutdown;
