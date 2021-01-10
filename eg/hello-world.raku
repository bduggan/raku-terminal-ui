#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup(:1pane);

ui.pane.put("Hello world. Press any key.");

ui.get-key;

ui.shutdown;

