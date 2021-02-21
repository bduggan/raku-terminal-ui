unit class Terminal::UI::Frame;
use Terminal::UI::Pane;
use Terminal::ANSI;
use Terminal::ANSI::OO :t;
use Terminal::UI::Utils;
use Log::Async;

logger.untapped-ok = True;
method pod { $=pod }

subset UInt of Int where * >= 0;

#| Offset from the top of the screen.  A maximized frame has top == 1.
has UInt $.top = 1;

#| Offset from the left of the screen.  A maximized frame has left == 1.
has UInt $.left = 1;

#| Number of rows, including the top and bottom borders
has UInt $.height is required;

#| Number of columns
has UInt $.width;

#| List of rows with dividers in the frame.
has UInt @.dividers;

#| The panes for the frame.
has Terminal::UI::Pane @.panes;

#| The screen associated with the frame.
has $.screen;

#| Characters for drawing the frame border.
has %.border = {
   side     => '║',         # '│',
   top      => '═',         # '─',
   bottom   => '═',         # '─',
   divider  => '─',
   corners  => < ╔ ╗ ╝ ╚ >, # <┌ ┐ ┘ └>,
   edges    => <╟ ╢>,       # < ├ ┤ >
 };

#| A function to compute an array of heights of panes, given the screen height.
has $.height-computer;

#| The focused pane
has Terminal::UI::Pane $.focused;

#| A name for this frame (optional)
has $.name = 'unnamed';

#| The row of the bottom (top + height - 1)
method bottom {
  $.top + $!height - 1;
}

#| The rightmost column (left + width - 1)
method right {
  $.left + $.width - 1;
}

#| Add a divider to the frame at the given row (between 1 and height)
method add-divider(UInt $line) {
  die "bad divider line ($line)" unless 1 < $line < $!height;
  @.dividers.push: $line;
}

#| Validate that the heights of the panes + the dividers add up
method check(@panes) {
  my $pane-heights = sum @panes.map: *.height;
  if @panes > 1 && @.dividers != @panes - 1 {
    return "wrong number of dividers ({+@.dividers}) for panes ({+@panes})";
  }
  if @panes == 1 && @.dividers > 0 {
    return "Only one pane, but there are dividers";
  }
  if @panes > 1 {
    my $total = sum @panes.map: *.height;
    if $total + @.dividers + 2 != $.height {
      abort("height ($.height) does not match sum of pane heights ($total) + dividers ({+@.dividers}) + borders (2)");
    }
  }
  return Nil
}

has $.border-color is rw = t.bright-white;

method !color($str = '') {
  $.border-color ~ $str;
}

#| Draw or refresh this frame
method draw {
  atomically {
    print-at($.top, $.left, self!color);
    print-at($.top,    $.left + 1, (%.border<top>    x ($.width - 2) ));
    print-at($.bottom, $.left + 1, (%.border<bottom> x ($.width - 2) ));
    self.draw-side($_) for 1 .. $.height - 2;
    print-at($.top,    $.left,  (%.border<corners>[0]));
    print-at($.top,    $.right, (%.border<corners>[1]));
    print-at($.bottom, $.right, (%.border<corners>[2]));
    print-at($.bottom, $.left,  (%.border<corners>[3]));
    for @.dividers -> $d {
      print-at($.top + $d,$.left,  (%.border<divider> x $.width));
      print-at($.top + $d,$.left,  (%.border<edges>[0]));
      print-at($.top + $d,$.right, (%.border<edges>[1]));
    }
  }
}

#| Draw only the sides, of a particular row
method draw-side($h) {
  print-at($.top + $h, $.left, self!color(%.border<side>));
  print-at($.top + $h, $.right,self!color(%.border<side>));
}

#| Given a string, combine it with borders of the frame, to make a printable row
method compose-line($str) {
  if ?%*ENV<HARNESS_ACTIVE> {
    return %.border<side>
         ~ $str.fmt("%-" ~ ($.width - 2) ~ 's')
         ~ %.border<side>;
  }
  my $fwd = t.cursor-right($.width - 2);
  my $bck = t.cursor-left($.width - 1);
  self!color(%.border<side> ~ $fwd ~ %.border<side>) ~ $bck ~ $str.fmt("%-" ~ ($.width - 2) ~ 's')
}

#| Create a single pane for this frame
method add-pane {
  self.add-panes(heights => [ self.height - 2 ]);
  @.panes.tail;
}

#| Number of dividers.  Will be number of panes - 1, when panes are added.
has $.number-of-dividers is rw;

#| Add multiple panes with the given height ratios
multi method add-panes(:$ratios!, :$height-computer) {
  my $n = $ratios.elems;
  my $s = $ratios.cache.sum;
  debug "adding panes, ratios: {$ratios.raku}, sum $s";
  $!number-of-dividers = $n - 1;
  $!height-computer = $height-computer // -> $available-rows {
    debug "computing heights, to add up to $available-rows";
    my $base = $available-rows div $s;
    my @h = ($base xx $n) >>*>> @$ratios;
    debug "base $base heights are {@h.join(' ')}";
    while @h.sum < $available-rows {
      @h[$++ % @h.elems]++;
      debug "adjusting.  base $base heights are now {@h.join(' ')}";
    }
    @h;
  }
  my @heights = $!height-computer(self.available-rows);
  debug "heights are now {@heights}";
  self.add-panes(heights => @heights, :$height-computer)
}

#| Add multiple panes with the given heights, and optionally a callback for computing heights
multi method add-panes(:$heights!, :$height-computer) {
  if $heights.grep(Pair) {
    my $have = $heights.grep(Int).sum;
    my $want = self.height - $heights.elems - 1;
    my $left = $want - $have;
    my $frs = $heights.grep(Pair).map(*.value).sum;
    my $fr-base = $left div $frs;
    my @changed;
    for @$heights.kv -> $i, $h is rw {
      if $h ~~ Pair {
        @changed.push: $i;
        $h = $fr-base * $h.value;
      }
    }
    while @$heights.sum < $want {
      @$heights[@changed[ $++ ]]++;
    }
  }
  $!number-of-dividers //= $heights.elems - 1;
  my $have = $heights.sum + $!number-of-dividers + 2;
  unless $have == self.height {
    abort("heights don't add up.  heights: {$heights.join(' + ')} dividers: $!number-of-dividers + 2 borders = $have, != {self.height}");
  }
  $!height-computer = $_ with $height-computer;
  my @panes;
  my $at = 1;
  for @$heights -> $height {
    debug "Adding pane of height $height";
    @panes.push: Terminal::UI::Pane.new(:frame(self), :$height, :top(self.top + $at));
    $at += $height;
    debug "Adding divider at $at";
    self.add-divider($at) if $at < self.height - 1;
    $at += 1;
  }
  self.check(@panes) andthen warning "$_";
  @!panes = @panes;
  $!number-of-dividers = @panes - 1;
  @panes;
}

#| Number of available rows: height - 2 - (number of dividers - 1)
method available-rows {
  exit note "Please set number-of-dividers" without self.number-of-dividers;
  my $a = $.height - 2 - (self.number-of-dividers);
  info "available rows in frame $.height - 2 - {self.number-of-dividers} = $a";
  $a;
}

#| Change focus to a particular pane in this frame
method focus(Terminal::UI::Pane $pane) {
  $!focused = $pane;
  for @.panes -> $p {
    if $p === $pane {
      $p.focus;
    } else {
      $p.unfocus;
    }
  }
  $pane;
}

#| Handle a resize of the screen
method handle-resize(:$from-width, :$from-height, :$to-width, :$to-height) {
  info "resize from $from-width x $from-height to $to-width x $to-height";
  $!height += $to-height - $from-height;
  $!width += $to-width - $from-width;
  without $!height-computer {
    info "no height-computer";
    for @.panes -> $p {
      $p.set-size( $p.width + ($to-width - $from-width) , $p.height );
    }
    return;
  }
  my $at = 1;
  @.dividers = ();
  my @pane-heights = $!height-computer(self.available-rows);
  info "recomputed heights: {@pane-heights.join(' ')}";
  for @pane-heights -> $h {
    my $b = @.panes[$++];
    $b.set-size( $b.width + ($to-width - $from-width) , $h );
    $b.set-top( self.top + $at );
    $at += $h;
    self.add-divider($at) if $at < self.height - 1;
    $at += 1;
  }
  self.check(@!panes) andthen warning "$_";
  for @!panes {
    .reformat;
    .redraw;
  }
  self.draw;
}

#| If there is only one pane, return it.
method pane {
  exit note "ambiguous call to pane: {@.panes.elems} panes" unless @.panes==1;
  @.panes.first;
}

=NAME Terminal::UI::Frame -- A border, which may have several panes

=begin DESCRIPTION

A frame is like a window frame -- it represents the border,
and may have several panes within it.

=end DESCRIPTION

