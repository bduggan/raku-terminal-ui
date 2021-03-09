
use Terminal::UI 'ui';

ui.setup(:1pane);

ui.pane.put("edit test-$_", meta => %(:file<<"test-$_">>) ) for 1..10;

ui.pane.on: select => -> :%meta {
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

ui.interact;

ui.shutdown;


