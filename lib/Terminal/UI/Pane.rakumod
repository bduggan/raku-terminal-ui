unit class Terminal::UI::Pane;
use Terminal::ANSI;
use Log::Async;
use Terminal::UI::Style;
use Terminal::UI::Utils;
use Terminal::ANSI::OO 't';
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

#| Is it focusable?
has Bool $.focusable is rw = True;

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

#| Lines of content: exactly what is sent to the screen (including formatting characters)
has @.lines;

#| Lines of raw content: unformatted, contains arrays sent to the put method
has @.raw;

#| Metadata for each line
has @.meta;

#| Style singleton
has $.style handles <colors> = Terminal::UI::Style.singleton;

#| A set of callable actions
has Callable:D %.actions;

#| A set of callable actions which will be called synchronously
has %!sync-actions;

#| Scroll automatically when putting a new line?
has Bool $.auto-scroll is rw = True;

has Lock $!write-lock .= new;

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

method reformat {
  for 0..^@!lines {
    self!format-line($_);
  }
}

#| Change the size
method set-size($!width,$!height) { }

method !format-line(Int $i) {
  with @!raw[$i] {
    my @args = @!raw[$i];
    @!lines[$i] = self!raw2line(@args);
  } else {
    error "no raw line $i";
  }
}

#| Change the offset from the top
method set-top($!top) { }

#| Metadata associated with the current line
method current-meta {
  return without $!current-line;
  @.meta[ $!current-line ]
}

#| The index of the current line
method current-line-index {
  $!current-line;
}

#| The text of the current line
method current-line {
  return without $!current-line;
  @.lines[ $!current-line ]
}

#| Draw the currently selected line
method draw-selected-line {
  return without self.selected-row;
  my Int $l = self.selected-row;
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
  return if @.lines == 0;
  $!first-visible //= @.lines.elems max $!height;
  self.select($!first-visible + $r);
}

#| Select the first row of content
method select-first {
  return unless @!lines;
  self.select(0);
}

#| Select the last row of content
method select-last {
  return unless @!lines;
  self.select(@!lines.elems - 1);
}

#| Select the last visible row.
method select-last-visible {
  self.select-visible(self.height - 1);
}

#| Select the last visible row.
method select-first-visible {
  self.select-visible(0);
}

method validate {
  without $!current-line {
    info "no current line";
    return;
  }
  my $str = "checking first-visible ($!first-visible) <= current ($!current-line) <= last ({self.last-visible})";
  info $str;
  abort("failed $str") unless $!first-visible <= $!current-line <= self.last-visible;
}

#| Select an index in the content.
method select($line!) {
  info "selecting line $line";
  unless @!lines {
    warning "cannot select line {$line.raku}, no content";
    return;
  }
  unless $!first-visible <= $line <= self.last-visible {
    my $prev-row = $!current-line // 0;
    $!current-line = $line;
    my $lines = $line - $prev-row;
    info "selecting line $line, need to scroll up (or down) by $lines";
    if $lines > 0 {
      self.scroll-up: :$lines;
    } else {
      self.scroll-down: lines => -$lines;
    }
    self.redraw;
    return;
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

#| Select the line $n above the current one, possibly scrolling the screen down
method select-up($n = 1) {
  without $!current-line {
    warning "cannot select up, no current line";
    return;
  }
  my $actual = $n min $!current-line;
  info "select up by $n, current line $!current-line, actual is $actual";
  return unless $actual >= 1;
  # self.scroll-down if $!current-line == $!first-visible;
  self.select($!current-line - $actual);
}

method !trace($msg) {
  debug sprintf(
    "current-line %s, first-visible %s, lines %s, height %s: $msg",
    ($!current-line // 'nil'), ($!first-visible // 'nil'), @!lines.elems, $.height
  );
}

#| Select the line $n lines below the current one, possibly scrolling the screen up
method select-down($n = 1) {
  without $!current-line {
    warning "cannot select down, no current line";
    return;
  }
  my $actual = $n min (@!lines.elems - $!current-line - 1);
  info "select down $n, actual is $actual";
  return unless $actual >= 1;
  self.select($!current-line + $actual);
}

#| Move the selector down 10 rows
method select-down_10 {
  self.select-down(10);
}

#| Move the selector up 10 rows
method select-up_10 {
  self.select-up(10);
}

#| Select down by the number of lines in the pane
method page-down {
  self.select-down($.height);
}

#| Select up by the number of lines in the pane
method page-up {
  self.select-up($.height);
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
  my $str = @!lines[$!first-visible + $row - 1] // ''; 
  my Int $h = self.top + $row.trim - 1;
  if $border && $inner && self.frame {
    self.frame.print-line($h,"$str");
  } elsif $border && self.frame {
    self.frame.draw-side($row);
  } elsif $inner {
    $str = $str.fmt("%-{ self.width }s");
    print-at $h, self.left, "$str";
  } else {
    error "bad arguments";
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
  debug "redrawing {self.name}.  selected row is {self.selected-row // 'undefined'}";
  $!write-lock.lock;
  for 1..$.height {
    if self.selected-row and $_ == self.selected-row {
      self.draw-selected-line;
    } else {
      self!draw-row($_);
    }
  }
  $!write-lock.unlock;
}

#| Scroll the visible contents up.  Optionally limit scrolling based on the contents.
method scroll-up(Bool :$limit = True, Int :$lines = 1) {
  debug "scroll up by $lines";
  my $actual;
  if $limit && $!first-visible + self.height + $lines > self.lines.elems {
    $actual = - ( $!first-visible + self.height - self.lines.elems );
    warning "cannot scroll up because first visible + height >= elems, will scroll $actual instead";
    return if $actual == 0;
  }
  if (self!has-vertical-overlap) {
    $!first-visible += ($actual // $lines);
    if $!current-line < self.first-visible {
      $!current-line = self.first-visible;
    }
    self.redraw;
    return;
  }
  atomically {
    self!set-scroll-region;
    scroll-up($actual // $lines);
  }
  $!first-visible += ($actual // $lines);
  if $!current-line < self.first-visible {
    $!current-line = self.first-visible;
  }
  self.draw-selected-line;
  self!draw-row(self.height - $_) for 0...^($actual // $lines);
}

#| Scroll the visible contents down.  Optionally limit scrolling based on the contents.
method scroll-down(Int :$lines = 1) {
  debug "scroll down by $lines";
  my $actual;
  if $!first-visible < $lines {
    $actual = $!first-visible;
    debug "limiting to $actual, not $lines";
    return if $actual == 0;
  }
  if (self!has-vertical-overlap) {
    $!first-visible -= ($actual // $lines);
    if $!current-line > self.last-visible {
      $!current-line = self.last-visible;
    }
    self.redraw;
    return;
  }
  atomically {
    self!set-scroll-region;
    scroll-down($actual // $lines);
  }
  $!first-visible -= ($actual // $lines);
  with $!current-line {
    if $!current-line > self.last-visible {
      $!current-line = self.last-visible;
    }
    abort("scrolling calculation wrong") without self.selected-row;
    self.draw-selected-line;
  }
  self!draw-row($_) for 1..($actual // $lines);
}

#| Selected row, in the range 1..$!height
method selected-row {
  return Nil without $!current-line;
  return Nil without $!first-visible;
  return Nil unless $.focusable;
  my $r = $!current-line - $!first-visible + 1;
  unless 1 <= $r <= $.height {
    warning "selected row $r is out of range (height: {$.height})";
    return;
  }
  $r;
}

#| Clear and add content centered vertically and horizontally
multi method splash(@content, :$center = True) {
  self.clear;
  my $top = (self.height div 2) - (@content.elems div 2);
  for @content.kv -> $i, $arg {
    self.update: :line($top + $i), @$arg, :$center;
  }
}

#| Clear and add content centered vertically and horizontally
multi method splash($content, :$center = True) {
  self.clear;
  my $top = (self.height div 2) - ($content.lines.elems div 2);
  for $content.lines.kv -> $i, $str {
    self.update: :line($top + $i), "$str", :$center;
  }
}

multi method update(Str $content, Int :$line!, Bool :$center, :%meta) {
  self.update([$content], :$line, :$center, :%meta);
}

#| Update a line of content
multi method update($content, Int :$line!, Bool :$center, :%meta) {
  if $line > @!lines.elems - 1 {
    for @!lines.elems .. $line {
      # autovivify
      self.put("",:!scroll-ok);
    }
  }
  @!meta[$line] = %meta with %meta;
  @!lines[$line] = self!raw2line($content, :$center);
  @!raw[$line] = $content;
  self!draw-row($line + 1 - $!first-visible);
}

sub sanitize(Str(Mu) $s) {
  return "" unless $s && $s.defined;
  $s.trans("\t" => '  ', :g);
}

method !centered($str) {
  my $cnt = sanitize($str).fmt("%{self.width div 2 + $str.chars div 2}s");
  $cnt.fmt("%-{self.width}s");
}

#| Add lines of content, possibly scrolling.
#| Content is added one line at a time -- the content
#| can be any type that has a 'lines' method.
multi method put($content, Bool :$scroll-ok = $.auto-scroll, Bool :$center, :%meta) {
  $!write-lock.lock;
  LEAVE $!write-lock.unlock;
  # self.validate;
  without $content {
    warning "content is undefined";
    return;
  }
  if $content ~~ IO or $content.?lines > 1 {
    for $content.lines -> $l {
      self.put(~$l, :$scroll-ok, :$center, :%meta);
    }
    return;
  }
  my $str := $content.Str;
  $!first-visible //= 0;
  $!current-line //= 0;
  my $should-scroll = self.last-visible == (@!lines - 1);
  @!meta[ @!lines.elems ] = %meta with %meta;
  with @!raw[ @!lines.elems ] { 
    warning "cannot center formatted text" if $center;
    @!lines.push: sanitize($str);
    # raw done, don't calculate
  } else {
    if $center {
      my $cnt = sanitize($str).fmt("%{self.width div 2 + $str.chars div 2}s");
      @!lines.push: $cnt.fmt("%-{self.width}s");
    } else {
      @!lines.push: sanitize($str).substr(0,self.width).fmt("%-{self.width}s");
    }
    @!raw.push: $str;
  }
  if $scroll-ok && $should-scroll {
    self.scroll-up; # draws the row at self.height
  } else {
    self!draw-row(@!lines.elems - $!first-visible, :maybe);
  }
  self;
}

method !raw2line(@args, Bool :$center) {
  my $line = '';
  my $left = $.width;
  for @args {
    when Str {
     with .substr(0,$left) {
       $line ~= $_;
       $left -= .chars;
     }
    }
    when Pair {
      $line ~= .key;
      with (.value // '').substr(0,$left) {
        $line ~= $_;
        $left -= .chars;
      }
    }
    default {
      error "unknown arg: " ~ .^name ~ ' -- ' ~ (.raku);
    }
    last unless $left > 0;
  }
  if $center {
    $line = (" " x ($left div 2)) ~ $line ~ t.text-reset ~ (" " x ( $left - ($left div 2)));
  } else {
    $line ~= t.text-reset ~ (" " x $left);
  }
  $line;
}

#| Put formatted text.  Each element is either a string or a pair.  Strings
#| are printed.  Keys of pairs are printed, and then their values.  Keys are
#| assumed to be formatting, and do not count towards the length of the line.
multi method put(@args, Bool :$scroll-ok = $.auto-scroll, :%meta) {
  die "escape character in args: please use a pair" if @args.grep: { $_ ~~ Str && /\e/ }
  my $i = @!lines.elems;
  @!raw[ $i ] = @args.clone;
  self.put(self!raw2line(@args), :$scroll-ok, :%meta);
}

#| Focus on this pane
method focus {
  info "focusing";
  $!focused = True;
  if @!lines == 0 {
    self.put: "";
  }
  self.draw-selected-line;
  self;
}

#| Remove focus from this pane
method unfocus {
  info "unfocusing";
  $!focused = False;
  self.draw-selected-line;
  self;
}

#| Clear the content and redraw
method clear {
  @!lines = (" " x $.width) xx $.height;
  $!current-line = 0;
  self.redraw;
  @!lines = ();
  @!meta = ();
  @!raw = ();
  $!current-line = Nil;
  $!first-visible = Nil;
}

#| Associate callbacks with events
multi method on(*%kv) {
   for %kv.pairs {
     self.on(name => .key, action => .value);
   }
}

#| Associate a callback, with the name of an action
multi method on(Str :$name!, Callable :$action!) {
  %!actions{ $name } = $action
}

multi method on-sync(*%kv) {
   for %kv.pairs {
     self.on-sync(name => .key, action => .value);
   }
}

#| Associate a synchronous callback, with the name of an action
multi method on-sync(Str :$name!, Callable :$action!) {
  %!actions{ $name } = $action;
  %!sync-actions{ $name } = True;
}

#| Run the action with the given name
method call($name) {
  if $name eq <select-up select-down select-last select-first page-up page-down select-down_10 select-up_10 clear>.any {
    return self."$name"() unless %!actions{ $name };
  }
  unless %!actions{ $name } {
    info "no action for $name in pane {self.name}";
    return;
  }
  my &code := %!actions{ $name };
  my %sig = &code.signature.params.grep(*.named).map(*.name => 1);
  my %args;
  %args<meta> = self.current-meta if %sig{'$meta'};
  if %sig{'%meta'} {
    my %meta = self.current-meta.Hash;
    %args<meta> = %meta;
  }
  %args<raw> = @!lines[$!current-line] if %sig{'$raw'};
  debug "sending args for $name: " ~ %args.keys.join(',');
  if %!sync-actions{$name} {
    code(|%args);
  } else {
    start code(|%args);
  }
}

#| Run a shell command, and send the lines of the output to this pane, optionally filtering the output
method exec(@cmd, :$filter) {
  debug "running @cmd";
  my $proc = run |@cmd, :out, :err;
  for $proc.out.lines -> $text {
    self.put("$text") if !$filter.defined || ($text ~~ $filter);
  }
  for $proc.err.lines -> $text {
    self.put("error: $text");
  }
  debug "done " ~ $proc.exitcode;
}

=NAME Terminal::UI::Pane -- An area that contains scrollable text

=begin DESCRIPTION

A pane is a text area that can scroll.  It also has as registry of
actions, which may be referenced by name.

=end DESCRIPTION

