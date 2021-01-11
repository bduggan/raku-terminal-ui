unit class Terminal::UI::Pane;
use Terminal::ANSI;
use Log::Async;
use Terminal::UI::Style;
logger.untapped-ok = True;
method pod { $=pod }

subset UInt of Int where * >= 0;

#| Absolute top of the pane (default: top of the frame + 1)
has UInt $.top;

#| Absolute left edge of the pane (default: left of the frame + 1)
has UInt $.left;

#| Number of rows in the pane
has UInt $.height;

#| Number of columns
has UInt $.width;

#| Whether this pane is currently focused
has Bool $.focused;

#| Index into @.lines (negative if we scrolled down): first line in the pane
has Int $.first-visible = Nil;

#| Index into @.lines (negative if we scrolled down): currently selected line
has Int $!current-line = Nil;   # index into @.lines

#| Optional descriptive name
has $.name is rw = 'unnamed';

#| The frame associated with this pane
has $.frame handles <screen>;

#| Lines of content
has @.lines;

#| Metadata for each line
has @.meta;

#| Style singleton
has $.style handles <colors> = Terminal::UI::Style.singleton;

#| A set of callable actions
has %.actions;

method TWEAK {
  return without $.frame;
  $!height ||= $.frame.height - 2;
  $!top    ||= $.frame.top + 1;
  $!width  ||= $.frame.width - 2;
  $!left   ||= $.frame.left + 1;
}

#| Absolute bottom (top + height)
method bottom { $.top + $.height; }

#| Absolute right column (left + width)
method right { $.left + $.width; }

#| Change the size
method set-size($!width,$!height) { }

#| Change the offset from the top
method set-top($!top) { }

#| Metadata associated with the current line
method current-meta {
  @.meta[ $!current-line ]
}

#| The text of the current line
method current-line {
  @.lines[ $!current-line ]
}

#| Draw the currently selected line
method draw-selected-line {
  return without self.selected-row;
  my $l = self.selected-row;
  if $.focused {
    atomically {
      set-bg-color(self.colors<focused><selected><bg>);
      set-fg-color(self.colors<focused><selected><fg>);
      self!draw-row($l, :inner, :!border);
      normal-video;
      self!draw-row($l, :!inner, :border);
    }
  } else {
    atomically {
      set-bg-color(self.colors<unfocused><selected><bg>);
      set-fg-color(self.colors<unfocused><selected><fg>);
      self!draw-row($l, :inner, :!border);
      normal-video;
    }
  }
}

#| Select a visible row.  (0 is the top row)
method select-visible(Int $r) {
  error "first visible not yet set" without $!first-visible;
  self.select(self.first-visible + $r);
}

#| Select an index in the content.
method select($line is copy = ($!current-line // $!first-visible)) {
  without $line {
    unless @!lines {
      warning "cannot select line {$line.raku}, no content";
      return;
    }
    $!first-visible //= @.lines.elems max $!height;
    $!current-line //= $.first-visible // 0;
    $line = $!current-line;
  }
  unless $!first-visible <= $line <= self.last-visible {
    warning "selecting a line that is not visible: $!first-visible <= $line <= { self.last-visible }";
    return
  }
  my $prev-row = self.selected-row;
  $!current-line = $line;
  self.draw-selected-line;
  with $prev-row {
    self!draw-row($prev-row) if $prev-row != self.selected-row;
  }
}

#| Index of the bottom line which is visible (first-visible + height - 1)
method last-visible {
  $!first-visible + $!height - 1;
}

#| Select the line above the current one, possibly scrolling the screen down
method select-up {
  without $!current-line {
    warning "cannot select up, no current line";
    return;
  }
  return unless $!current-line >= 1;
  self.scroll-down if $!current-line == $!first-visible;
  self.select($!current-line - 1);
  self.draw-selected-line;
}

method !trace($msg) {
  debug sprintf(
    "current-line %s, first-visible %s, lines %s, height %s: $msg",
    ($!current-line // 'nil'), ($!first-visible // 'nil'), @!lines.elems, $.height
  );
}

#| Select the line below the current one, possibly scrolling the screen up
method select-down {
  without $!current-line {
    warning "cannot select down, no current line";
    return;
  }
  unless $!current-line < @!lines.elems - 1 {
    warning "cannot select down, check failed: $!current-line <= { @!lines.elems - 1 }";
    return;
  }
  self.scroll-up if $!current-line == self.last-visible;
  self.select($!current-line + 1);
}

#| Select down by the number of lines in the pane
method page-down {
  self.select-down for 1..^$.height;
}

#| Select up by the number of lines in the pane
method page-up {
  self.select-up for 1..^$.height;
}

method !set-scroll-region {
  set-scroll-region(self.top, self.bottom - 1);
}

method !draw-row($row, Bool :$border = True, Bool :$inner = True, Bool :$maybe = False) {
  unless (1 ≤ $row ≤ $.height) {
    warning "draw-row -- line out of range; should be 1 ≤ $row ≤ $.height" unless $maybe;
    return;
  }
  return without $!first-visible;
  my $str-in = @!lines[$!first-visible + $row - 1] // ''; 
  my $str;
  if $str-in.chars < self.width {
    $str = $str-in.fmt("%-{ self.width}s");
  } elsif $str-in.chars > self.width {
    $str = $str-in.substr(0,self.width);
  } else {
    $str = $str-in;
  }
  my $h = self.top + $row - 1;
  if $border && $inner && self.frame {
    $str = $str.fmt("%-{ self.width}s");
    print-at $h, self.frame.left, self.frame.compose-line("$str");
  } elsif $border && self.frame {
    self.frame.draw-side($row);
  } elsif $inner {
    print-at $h, self.left, "$str";
  }
}

method !has-vertical-overlap {
  return False without self.frame;
  self.frame.screen.pane-count(min => self.top, max => self.bottom) > 1;
}

#| Same as redraw
method draw {
  self.redraw;
}

#| Refresh the screen
method redraw {
  for 1..$.height {
    if self.selected-row and $_ == self.selected-row {
      self.draw-selected-line;
    } else {
      self!draw-row($_);
    }
  }
}

#| Scroll the visible contents up.  Optionally limit scrolling based on the contents.
method scroll-up(Bool :$limit = True) {
  return if $limit && $!first-visible + self.height >= self.lines.elems;
  if (self!has-vertical-overlap) {
    $!first-visible++;
    self.redraw;
    return;
  }
  atomically {
    self!set-scroll-region;
    scroll-up;
  }
  $!first-visible++;
  self!draw-row(self.height);
}

#| Scroll the visible contents down.  Optionally limit scrolling based on the contents.
method scroll-down(Bool :$limit = True) {
  return if $limit && $!first-visible == 0;
  if (self!has-vertical-overlap) {
    $!first-visible--;
    self.redraw;
    return;
  }
  atomically {
    self!set-scroll-region;
    scroll-down;
  }
  $!first-visible--;
  self!draw-row(1);
}

#| Selected row, in the range 1..$!height
method selected-row {
  return without $!current-line;
  return without $!first-visible;
  my $r = $!current-line - $!first-visible + 1;
  unless 1 <= $r <= $.height {
    warning "selected row $r is out of range";
    return;
  }
  $r;
}

#| Add a line to the content.
#| Scroll down if the last line is visible and this line would be off screen.
method put($str where *.lines <= 1, Bool :$scroll-ok = True, :%meta) {
  $!first-visible //= 0;
  my $should-scroll = self.last-visible == (@!lines - 1);
  @!meta[ @!lines.elems ] = %meta with %meta;
  @!lines.push: $str;
  if $scroll-ok && $should-scroll {
    self.scroll-up; # draws the row at self.height
  } else {
    self!draw-row(@!lines.elems - $!first-visible, :maybe);
  }
  self;
}

#| Focus on this pane
method focus {
  $!focused = True;
  self.select($!current-line // $!first-visible);
  self;
}

#| Remove focus from this pane
method unfocus {
  $!focused = False;
  self.select($!current-line // $!first-visible);
  self;
}

#| Clear the content and redraw
method clear {
  @!lines = "" xx $.height;
  $!current-line = 0;
  self.redraw;
  @!lines = ();
  @!meta = ();
  $!current-line = Nil;
  $!first-visible = Nil;
}

#| Associate a callback, with the name of an action
method register-action(Str :$name, Callable :$action) {
  %!actions{ $name } = $action
}

#| Run the action with the given name
method run-action($name) {
  my &code := %!actions{ $name };
  code();
}

=NAME Terminal::UI::Pane -- An area that contains scrollable text

=begin DESCRIPTION

A pane is a text area that can scroll.  It also has as registry of
actions, which may be referenced by name.

=end DESCRIPTION

