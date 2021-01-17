
use Terminal::UI::Pane;
use Terminal::UI::Frame;
use Terminal::UI::Screen;
use Terminal::UI::Style;
use Log::Async;

sub EXPORT($ui = Nil) {
  my %h =
    "Terminal::UI" => Terminal::UI,
    "Terminal::UI::Screen" => Terminal::UI::Screen,
    "Terminal::UI::Pane" => Terminal::UI::Pane,
    "Terminal::UI::Frame" => Terminal::UI::Frame,
    "Terminal::UI::Input" => Terminal::UI::Input,
    "Terminal::UI::Style" => Terminal::UI::Style;
  %h{$ui} = Terminal::UI.new if $ui;
  %h;
}

unit class Terminal::UI:ver<0.0.1>;

logger.untapped-ok = True;

method pod { $=pod }

#| The screen object, which tracks frames and panes.
has Terminal::UI::Screen $.screen handles <pane panes frames find-frame>;

#| The object for getting input.
has Terminal::UI::Input $.input handles <get-key>;

#| The currently focused frame.
has Terminal::UI::Frame $.focused-frame;

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
method refresh {
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
  $!focused-frame = self.find-frame($frame);
  $!focused-frame.focus($!focused-frame.panes[$pane])
}

#| Set the next pane to be focused.
multi method focus(Str :$pane where * eq 'next') {
  my Int $current = $!focused-frame.panes.first: :k, * === $.focused;
  fail "no current pane" without $current;
  my $count = $!focused-frame.panes.elems;
  my $next = ($current + 1) % $count;
  fail "no next frame" without $next;
  self.focus(pane => $next);
}

#| Set a pane and frame to be focused, using the indexes (default 0,0).
multi method focus(Int :$pane, Int :$frame = 0) {
  $!focused-frame = self.frames[$frame] // die "frame $frame out of range";
  my $p = $!focused-frame.panes[$pane] // die "No pane $pane";
  $!focused-frame.focus($p);
}

#| Set a pane and frame to be focused, using the frame.
multi method focus(Terminal::UI::Frame $frame!, Int :$pane = 0) {
  $!focused-frame = $frame;
  my $p = $!focused-frame.panes[$pane] // die "No pane $pane";
  $!focused-frame.focus($p);
}

#| Set up with a single pane
multi method setup(:$pane!) {
  exit note "$pane != 1" unless $pane == 1;
  self.add-screen.add-frame.add-pane;
  self.refresh;
}

#| Set up with a callback that computes heights based on the total available height
multi method setup(:&heights!) {
  my $f = self.add-screen.add-frame;
  my $panes = heights(100).elems;
  my $heights = heights($f.height - 2 - ( $panes - 1));
  my $height-computer = -> $h { heights($h - 1 - $panes) };
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
  $!screen.init;
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

