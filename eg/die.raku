
use Terminal::UI 'ui';

ui.setup(:1pane);

my $log = "/tmp/log-$*PID";

LEAVE { .IO.unlink with $log };

ui.log($log);

ui.pane.put: "press d to die, w to warn, t to quietly warn, b to background die";

ui.bind: d => { die "i'm dying!" }
ui.bind: b => { await start { put(1/0) } }
ui.bind: w => { warn "warning!" }
ui.bind: t => { ui.quietly({ warn "warning!" }) }

ui.interact;
ui.shutdown;
