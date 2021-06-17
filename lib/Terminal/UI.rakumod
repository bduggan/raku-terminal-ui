
use Terminal::UI::Pane;
use Terminal::UI::Frame;
use Terminal::UI::Screen;
use Terminal::UI::Style;
use Terminal::UI::Alerts;
use Log::Async;

sub EXPORT($ui = Nil) {
  my %h =
    "Terminal::UI" => Terminal::UI,
    "Terminal::UI::Screen" => Terminal::UI::Screen,
    "Terminal::UI::Pane" => Terminal::UI::Pane,
    "Terminal::UI::Frame" => Terminal::UI::Frame,
    "Terminal::UI::Input" => Terminal::UI::Input,
    "Terminal::UI::Style" => Terminal::UI::Style
    ;
  %h{$ui} = Terminal::UI.new if $ui;
  %h;
}

unit class Terminal::UI:ver<0.0.18>;

also does Terminal::UI::Alerts;

logger.untapped-ok = True;

method pod { $=pod }

#| The screen object, which tracks frames and panes.
has Terminal::UI::Screen $.screen handles <pane panes frames frame find-frame>;

#| The object for getting input.
has Terminal::UI::Input $.input handles <get-key>;

#| The currently focused frame.
has Terminal::UI::Frame $.focused-frame;

#| Key bindings for the focused pane
has %.pane-bindings =
  'k' => 'select-up',
  'K' => 'select-up_10',
  'Up' => 'select-up',
  'j' => 'select-down',
  'J' => 'select-down_10',
  'Down' => 'select-down',
  ' ' => 'page-down',
  'PageDown' => 'page-down',
  'PageUp' => 'page-up',
  'Enter' => 'select',
  '9' => 'select-last',
  '0' => 'select-first',
;

#| UI bindings (not specific to a pane)
has %.ui-bindings of Str =
  'q' => 'quit',
  "Tab" => 'select-next',
  "Untab" => 'select-prev',
  'h' => 'help'
;

#| Actions associated with bindings.
has %.ui-actions;

#| Synchronous actions associated with bindings.
has %!ui-sync-actions;

#| Lock the focus
has Bool $.lock-focus is rw;

#| Lock interaction to only a set of actions
has %.lock-interaction;

#| The UI is in an interact loop
has Bool $.interacting = False;

#| The currently focused pane within the currently focused frame.
method focused {
  fail "no focused frame" without $!focused-frame;
  $!focused-frame.focused;
}

method TWEAK {
  $!input = Terminal::UI::Input.new;
}

#| Synonym for refresh
method draw {
  self.refresh
}

#| Refresh the screen, the frames, and their panes.
method refresh(Bool :$hard) {
  $!screen.refresh if $hard;
  for $!screen.frames -> $f {
    $f.draw;
    for $f.panes -> $p {
      $p.draw;
    }
  }
  self;
}

#| Set a pane and frame to be focused, using the name of the frame.
multi method focus(Str :$frame!, Int :$pane! ) {
  return if self.lock-focus;
  $!focused-frame = self.find-frame($frame);
  $!focused-frame.focus($!focused-frame.panes[$pane])
}

#| Set the next pane to be focused.
multi method focus(Str :$pane where * eq 'next' | 'prev') {
  return if self.lock-focus;
  my Int $current = $!focused-frame.panes.first: :k, * === $.focused;
  fail "no current pane" without $current;
  my $count = $!focused-frame.panes.elems;
  my $next = $pane eq 'next' ?? ($current + 1) % $count !! ($current - 1) % $count;
  fail "no next frame" without $next;
  self.focus(pane => $next);
}

#| Set a pane and frame to be focused, using the indexes (default 0,0).
multi method focus(Int :$pane, Int :$frame = 0) {
  return if self.lock-focus;
  $!focused-frame = self.frames[$frame] // die "frame $frame out of range";
  my $p = $!focused-frame.panes[$pane] // die "No pane $pane";
  $!focused-frame.focus($p);
}

#| Set a pane and frame to be focused, using the frame.
multi method focus(Terminal::UI::Frame $frame!, Int :$pane = 0) {
  return if self.lock-focus;
  $!focused-frame = $frame;
  my $p = $!focused-frame.panes[$pane] // die "No pane $pane";
  $!focused-frame.focus($p);
}

#| Set a pane and frame to be focused, using the frame.
multi method focus(Terminal::UI::Frame $frame!, Terminal::UI::Pane :$pane!) {
  return if self.lock-focus;
  $!focused-frame = $frame;
  $!focused-frame.focus($pane);
}

#| Set up with a single pane
multi method setup(:$pane!) {
  exit note "$pane != 1" unless $pane == 1;
  self.add-screen.add-frame.add-pane;
  self.refresh;
}

multi method setup(Array :$heights!) {
  my $f = self.add-screen.add-frame;
  $f.add-panes(:$heights);
  self.refresh;
}

#| Set up with a callback with one frame that computes heights based on the total available height
multi method setup(Callable :&heights!) {
  info "setting up using callback for heights";
  my $f = self.add-screen.add-frame;
  my $pane-count = &heights(80).elems; # call once to count panes
  $f.number-of-dividers = $pane-count;
  my $height-computer = &heights;
  my $heights = heights(self.screen.frame.available-rows);
  if $heights.sum != self.screen.frame.available-rows {
    exit note "height computed { $heights.join(' + ')} == { $heights.sum }, not { self.screen.frame.available-rows }";
  }
  info "initial heights: " ~ $heights.join(',');
  $f.add-panes(:$heights, :$height-computer);
  self.refresh;
}

#| Set up with a number of panes; evenly sized.
multi method setup(Int :$panes!) {
  my $f = self.add-screen.add-frame;
  $f.add-panes(ratios => 1 xx $panes);
  self.refresh;
}

#| Set up with panes that have the given ratios.
multi method setup(:$ratios!) {
  my $f = self.add-screen.add-frame;
  $f.add-panes(:$ratios);
  self.refresh;
  self;
}

#| Shut down the UI, and optionally emit a message.
method shutdown($msg = Nil) {
 .shutdown($msg) with $!screen;
 .shutdown with $!input;
}

#| Add a screen to the ui.  Arguments are sent to the Screen contructor
method add-screen(|args --> Terminal::UI::Screen) {
  $!screen = Terminal::UI::Screen.new(|args);
  $!screen.init(self);
  debug "added {$!screen.rows} (rows) x {$!screen.cols} (cols) screen";
  $!screen
}

#| Starting logging to a file.
method log(Str $file) {
  logger.send-to($file);
  info "started log";
}

#| a Supply of keyboard input; ends when $done is seen.
method keys(Str :$done, --> Supply) {
  supply {
    loop {
      given self.get-key {
        done() if ($done.defined and ($_ eq $done));
        emit $_;
      }
    }
  }
}

#| The current metadata for the selected pane, within the selected frame
method selected-meta {
  self.focused.current-meta;
}

#| The global style object
method style {
  Terminal::UI::Style.singleton;
}

#| Move up one line in the selected pane of the selected frame
method select-up {
  self.focused.select-up;
}

#| Move down one line in the selected pane of the selected frame
method select-down {
  self.focused.select-down;
}

#| Bind keys to events on the focused pane.
multi method bind('pane', :$name, *%kv) {
  for %kv.pairs {
    if .value ~~ Callable {
      my $key = ($name // 'anonymous_' ~ 1.rand.fmt('%.03f'));
      %!pane-bindings{.key} = $key;
      for self.panes -> $p {
        my %args = $key => .value;
        $p.on(|%args);
      }
    } else {
      %!pane-bindings{.key} = .value;
    }
  }
}

#| Bind keys to UI events, independent of the focused pane.
multi method bind(*%kv) {
  for %kv.pairs {
    if .value ~~ Callable {
      my $key = 'anonymous_' ~ 1.rand.fmt('%0.03f');
      %!ui-bindings{.key} = $key;
      %!ui-actions{$key} = .value;
    } else {
      %!ui-bindings{.key} = .value;
    }
  }
}

multi method bind(*@pairs) {
  my $pane = @pairs.shift if @pairs.first ~~ Str && @pairs.first eq 'pane';
  for @pairs -> Pair $p {
    if $pane {
      self.bind('pane', |($p.key => $p.value))
    } else {
      self.bind(|($p.key => $p.value))
    }
  }
}

method !action-is-available(Str $action) {
  return True without %.lock-interaction;
  return True if %.lock-interaction.keys == 0;
  debug 'interaction is locked: ' ~ %.lock-interaction.raku;
  return %.lock-interaction{ $action };
}

#| Respond to keyboard input, until we are done
method interact {
  self.focus(pane => 0);
  $!interacting = True;
  react whenever self.keys(done => %( %.ui-bindings.invert )<quit>) {
    when %!pane-bindings.keys.any {
      with %!pane-bindings{$_} {
        info "Calling $_";
        self.focused.call($_) if self!action-is-available($_);
      }
    }
    when %.ui-bindings.keys.any {
      self.call(%!ui-bindings{$_}) if self!action-is-available($_);
    }
    default {
      info "unknown key {$_.raku}";
    }
  }
  $!interacting = False;
}

#| Associate names of actions with callables.
method on(*%actions) {
  for %actions.pairs {
    unless %!ui-bindings.invert.Hash{.key} {
      warning "no action for " ~ .key;
      warning "actions: " ~ %!ui-bindings.values.join(',');
    }
    %!ui-actions{.key} = .value
  }
}

#| Associate names of actions with synchronous callables.
method on-sync(*%actions) {
  for %actions.pairs {
    unless %!ui-bindings.invert.Hash{.key} {
      warning "no action for " ~ .key;
      warning "actions: " ~ %!ui-bindings.values.join(',');
    }
    %!ui-actions{.key} = .value;
    %!ui-sync-actions{.key} = True;
  }
}

#| Call the action with the given name.
method call(Str $action) {
  if $action eq 'help' {
    my $p = start self.alert(self.help-text, :!center);
    return $p;
  }
  return self.focus(pane => 'next') if $action eq 'select-next';
  return self.focus(pane => 'prev') if $action eq 'select-prev';
  without %!ui-actions{$action} {
    info "no ui action for $action";
    return;
  }
  my &codee := %!ui-actions{$action};
  if %!ui-sync-actions{$action} {
    codee();
    return;
  }
  start codee()
}

#| Suppress warnings and run code
method quietly(&code) {
  my $result;
  self.screen.quietly(self,{ $result = code() });
  $result;
}

#| Auto generated help text, based on bindings
method help-text {
  my @txt;
  my %pane;

  push @txt: 'pane:';
  push %pane, $_ for %.pane-bindings.invert;
  for %pane.antipairs.sort(*.value) -> (:key($k),:value($v)) {
    @txt.push: "{($k.sort>>.raku.join(',')).fmt('%20s')} : $v";
  }

  push @txt: '';
  push @txt: 'screen:';
  my %ui;
  push %ui, $_ for %.ui-bindings.invert;
  for %ui.antipairs.sort(*.value) -> (:key($k),:value($v)) {
    @txt.push: "{($k.sort>>.raku.join(',')).fmt('%20s')} : $v";
  }

  @txt.join("\n");
}

#| Pause the ui, run some code, and then restart
method pause-and-do(&code) {
  self.shutdown;
  code();
  self.screen.init(self);
}

=NAME Terminal::UI -- A framework for building terminal interfaces

=begin DESCRIPTION

Terminal::UI is a framework for building user interfaces
in the terminal.

This class provides routines for manipulating:

* a screen: the top level object representing the screen

* frames: borders around content

* panes: scrolling regions with content

* style: a global style

* input: input routines

These are documented in Terminal::UI::Screen, Frame, Pane, Style, and Input respectively.

=end DESCRIPTION

