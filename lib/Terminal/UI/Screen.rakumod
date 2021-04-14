unit class Terminal::UI::Screen;

use Terminal::UI::Frame;
use Terminal::UI::Input;
use Terminal::UI::Utils;
use Terminal::ANSI;
use Log::Async;

logger.untapped-ok = True;
method pod { $=pod }

#| The number of columns (default the entire screen).
has $.cols;

#| The number of rows (default the entire screen).
has $.rows;

#| Resize events.
has Supplier $.resized .= new;

#| The frames in the screen.
has SetHash $!frames;

method !auto-set {
  $!cols //= (%*ENV<TERMINAL_UI_COLS> // qx{ tput cols }.chomp).Int;
  $!rows //= (%*ENV<TERMINAL_UI_ROWS> // qx{ tput lines }.chomp).Int;
}

method TWEAK(:$cols,:$rows) {
  self!auto-set;
  self!setup-resizer;
}

#| Number of rows available (height - 2 for the border)
method available-rows {
  self.rows - 2;
}

#| The first frame (handy if it's the only one)
method frame {
  self.frames.head;
}

has $!warn-wraphandle;

#| Suppress all warnings (including popups) for a block of code
method quietly(\ui, &code) {
  $!warn-wraphandle.restore;
  $!warn-wraphandle = Nil;
  quietly {
    code();
  }
  self!trap-errors(ui);
}


#| Override die() and warn() to use alerts instead
method !trap-errors(\ui) {
  unless %*ENV<TERMINAL_UI_NATIVE_ERRORS> {
    $*SCHEDULER.uncaught_handler = -> $c {
      ui.alert(:title<error>, ~$c) if ui.interacting;
      warning "caught error {$c.^name}";
      my @trace = $c.backtrace.grep(!*.is-setting).map: {.file ~ ' line ' ~ .line}
      abort(($c || "error" ~ "\nin thread {$*THREAD.id}"), @trace);
    }
  }
  $!warn-wraphandle //= &warn.wrap: -> |c {
    ui.alert(:title<warning>, ~c) if ui.interacting;
    warning c.Str;
    warning .Str.trim for Backtrace.new;
  }
}

method !setup-resizer {
  start react whenever signal(SIGWINCH) {
    my $w = $!cols;
    my $h = $!rows;
    $!cols = $!rows = Nil;
    self!auto-set;
    next if $!cols == $w && $!rows == $h;
    $!resized.emit: "resized to { self.rows } x { self.cols }";
    self.handle-resize(from-width => $w,
                       from-height => $h,
                       to-width => self.cols,
                       to-height => self.rows);
    clear-screen;
    self.draw;
  }
}

#| Clear and set things up.
method init(\ui) {
  save-screen;
  clear-screen;
  cursor-off;
  self.draw;
  self!trap-errors(ui);
}

#| Refresh
method refresh {
  clear-screen;
  cursor-off;
  self.draw;
}

#| Handle a resize of the screen (e.g. a SIGWINCH)
method handle-resize(|args) {
  for $!frames.keys -> $c {
    $c.handle-resize(|args);
  }
}

#| Draw the entire screen
method draw {
  for $!frames.keys -> $k {
    $k.draw;
    for $k.panes -> $b {
      $b.redraw;
    }
  }
}

#| Shut down and reset the state, with an optional message
method shutdown($msg = Nil) {
  cursor-on;
  reset-scroll-region;
  restore-screen;
  clear-screen;
  put $msg with $msg;
}

method !generate-name {
  state $next = 1;
  return 'frame-' ~ $next++;
}

#| Add a frame to the screen.
method add-frame(
   :$top = 1,
   :$left = 1,
   :$width = self.cols - $left + 1,
   :$height = self.rows - $top + 1,
   :$name = self!generate-name,
   Bool :$center,
   --> Terminal::UI::Frame
) {
  my $f;
  info "creating frame, W x H is $width x $height, top is $top, left is $left";
  if $center {
    my $l = (self.cols - $width + 2) div 2;
    my $t = (self.rows - $height + 2) div 2;
    $f = Terminal::UI::Frame.new( :screen(self), :top($t), :$height, :left($l), :$width, :$name);
  } else {
    $f = Terminal::UI::Frame.new( :screen(self), :$top, :$height, :$left, :$width, :$name);
  }
  $!frames{ $f } = 1;
  $f.draw;
  $f;
}

#| Find a frame that has a given name
method find-frame($name! --> Terminal::UI::Frame) {
  self.frames.first: { $_.name eq $name }
}

#| Find the number of panes which have lines between two rows
method pane-count(:$min,:$max) {
  my %count;
  for $!frames.keys -> $c {
    for $c.panes -> $b {
      %count{ $b } = 1 if ( $min .. $max ) ∩ ( $b.top .. $b.bottom );
    }
  }
  return %count.keys.elems;
}

#| All the frames
method frames {
  $!frames.keys.sort;
}

#| When there is only one pane and only one frame, return it
method pane {
  my $frames = self.frames;
  warning "ambiguous call to pane; multiple frames" unless $frames.elems == 1;
  my $p = $frames[0].panes;
  abort "ambiguous call to panes" unless $p.elems == 1;
  return $p[0];
}

#| All the panes in all the frames.
method panes {
  my $frames = self.frames;
  warning "ambiguous call to pane; multiple frames. (maybe an alert?)" unless $frames.elems == 1;
  $frames[0].panes;
}

#| Remove a frame
method remove-frame(Terminal::UI::Frame $f) {
  $!frames{ $f }:delete;
}

=NAME Terminal::UI::Screen -- The entire screen.

=begin DESCRIPTION

This class represents the screen, which may have frames on
it, and the frames may have panes.

=end DESCRIPTION

