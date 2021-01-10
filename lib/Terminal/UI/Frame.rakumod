unit class Terminal::UI::Frame;
use Terminal::UI::Pane;
use Terminal::ANSI;
use Log::Async;

logger.untapped-ok = True;
method pod { $=pod }

subset UInt of Int where * >= 0;

#| Offset from the top of the screen.  A maximized frame has top == 1.
has UInt $.top = 1;

#| Offset from the left of the screen.  A maximized frame has left == 1.
has UInt $.left = 1;

#| Number of rows
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
has $!height-computer;

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
      return "height ($.height) does not match pane heights ($total) + top/bottom (2) + dividers ({+@.dividers})";
    }
  }
  return Nil
}

#| Draw or refresh this frame
method draw {
  print-at($.top,    $.left + 1, %.border<top>    x ($.width - 2) );
  print-at($.bottom, $.left + 1, %.border<bottom> x ($.width - 2) );
  self.draw-side($_) for 1 .. $.height - 2;
  print-at($.top,    $.left,  %.border<corners>[0]);
  print-at($.top,    $.right, %.border<corners>[1]);
  print-at($.bottom, $.right, %.border<corners>[2]);
  print-at($.bottom, $.left,  %.border<corners>[3]);
  for @.dividers -> $d {
    print-at($.top + $d,$.left,  %.border<divider> x $.width);
    print-at($.top + $d,$.left,  %.border<edges>[0]);
    print-at($.top + $d,$.right, %.border<edges>[1]);
  }
}

#| Draw only the sides, of a particular row
method draw-side($h) {
  print-at($.top + $h, $.left, %.border<side>);
  print-at($.top + $h, $.right,%.border<side>);
}

#| Given a string, combine it with borders of the frame, to make a printable row
method compose-line($str) {
  %.border<side> ~ $str.fmt("%-" ~ ($.width - 2) ~ 's') ~ %.border<side>;
}

#| Create a single pane for this frame
method add-pane {
  self.add-panes(heights => [ self.height - 2 ]);
  @.panes.tail;
}

#| Add multiple panes with the given height ratios
multi method add-panes(:$ratios!) {
  # ratios => [1 1]   -- two panes, the same height
  my $pane-count = $ratios.elems;
  my $dividers = $pane-count - 1;
  $!height-computer = -> $h {
    my $available = $h - 2 - $dividers;
    my @h;

    my $i = 0;
    for @$ratios -> $v { @h[$i++] = $available * ($v/$ratios.sum); }
    @h = @h.map: *.Int;

    $i = 0;
    while @h.sum < $available { @h[$i++]++; }
    @h;
  }
  my @heights = $!height-computer(self.height);
  self.add-panes(heights => @heights)
}

#| Add multiple panes with the given heights, and optionally a callback for computing heights
multi method add-panes(:$heights!, :$!height-computer) {
  my @panes;
  my $at = 1;
  for @$heights -> $height {
    @panes.push: Terminal::UI::Pane.new(:frame(self), :$height, :top(self.top + $at));
    $at += $height;
    self.add-divider($at) if $at < self.height - 1;
    $at += 1;
  }
  self.check(@panes) andthen warning "$_";
  @!panes = @panes;
  @panes;
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
  $!height += $to-height - $from-height;
  $!width += $to-width - $from-width;
  without $!height-computer {
    for @.panes -> $p {
      $p.set-size( $p.width + ($to-width - $from-width) , $p.height );
    }
    return;
  }
  my $at = 1;
  @.dividers = ();
  my @pane-heights = $!height-computer($!height);
  for @pane-heights -> $h {
    my $b = @.panes[$++];
    $b.set-size( $b.width + ($to-width - $from-width) , $h );
    $b.set-top( self.top + $at );
    $at += $h;
    self.add-divider($at) if $at < self.height - 1;
    $at += 1;
  }
  self.check(@!panes) andthen warning "$_";
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

