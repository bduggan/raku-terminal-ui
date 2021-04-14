
use Terminal::UI 'ui';
use Terminal::ANSI;

ui.setup(:1pane);

ui.pane.put("edit test-$_", meta => %(:file<<"test-$_">>) ) for 1..10;

ui.pane.on-sync: select => -> :%meta {
  shell "vim /tmp/" ~ %meta<file>;
  ui.refresh;
  ui.pane.put("saved %meta<file>");
};

ui.bind: 'pane', e => 'edit';
ui.pane.on-sync: edit => -> :%meta {
  shell "vim /tmp/" ~ %meta<file>;
  ui.refresh;
  ui.pane.put("saved %meta<file>");
};

ui.bind: i => 'input';
ui.on-sync: input => {
  ui.shutdown;
  my $got = prompt 'type something: ';
  ui.screen.init;
  ui.panes[0].put: "got $got";
}

ui.interact;

ui.shutdown;


