use Terminal::UI 'ui';

ui.setup(:8panes);
ui.log('log');

ui.panes[0].put("Hello world.");

ui.panes[1].put("press d to delete a pane");

ui.bind( 'pane', d => 'do-remove-pane');

for ui.panes.kv -> $i, $p {
  $p.put("pane $i");
  $p.on(do-remove-pane => {
   if ( ui.frame.remove-pane($p) ) {
     ui.refresh(:hard);
     ui.alert("removed pane $i");
     ui.panes[0].put: ui.screen.frame.check(ui.panes) // "no issues removing pane $i";
   } else {
     ui.alert("failed to remove pane $i");
   }
  });
}

ui.interact;

ui.shutdown;

