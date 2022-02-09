use Terminal::UI 'ui';

ui.setup(:2panes);

ui.panes[0].put("Hello world.");

ui.panes[1].put("press any key");

ui.get-key;

ui.frame.remove-pane(1);

ui.refresh(:hard);

ui.panes[0].put("it is gone!");

ui.get-key;

ui.shutdown;

