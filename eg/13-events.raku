#!/usr/bin/env raku

use Terminal::UI 'ui';

ui.setup: heights => [ 3, fr => 1, fr => 1];

my \tom = ui.panes[0];
my \earth = ui.panes[1];
my \mars = ui.panes[2];

tom.put: "Ground Control to Major Tom";
earth.put: "welcome to planet earth", meta => :planet<earth>;
mars.put: "welcome to planet mars",  meta => :planet<mars>;

my $commenced-countdown = False;
my $launched = False;

# bind: associate a key with an event.
ui.bind: c => 'commence-countdown';
ui.on: commence-countdown => {
  unless $commenced-countdown {
    $commenced-countdown = True;
    tom.put: "Commencing countdown engines on";
    for <ten nine eight seven six five four three two one> {
      tom.put("$_");
      sleep 3;
    }

    tom.put("liftoff 🚀");
    $launched = True;
  }
}

# bind 'pane': the event will receive the currently selected line from the pane
ui.bind: 'pane', s => 'step-through-door';
earth.on: step-through-door => -> :%meta { tom.put("Planet { %meta<planet> } is blue") }
mars.on: step-through-door => {
     if $launched {
       tom.put("You've really made the grade");
     } else {
       tom.put("Check ignition and may God's love be with you")
     }
   }
tom.on: step-through-door => -> {
    tom.put("Take your protein pills and put your helmet on.")
  }

ui.interact;
ui.shutdown;
