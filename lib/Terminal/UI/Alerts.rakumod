unit role Terminal::UI::Alerts;
use Log::Async;

multi method alert(Str $msg, Int :$pad = 0, Bool :$center = True, Str :$title) {
  self.alert($msg.lines.List, :$pad, :$center, :$title);
}

#| Show an alert box, and wait for a key press to dismiss it.
multi method alert(@lines, Int :$pad = 0, Bool :$center = True, Str :$title) {
  my Int $width = ((@lines>>.chars.max + 4) max 16) min (self.screen.cols - 4);
  info "ROWS in screen" ~ self.screen.rows;
  my Int $height = (4 + @lines) min (self.screen.rows - 3);
  $height += 2 if $title;
  info "alert ($width x $height)";
  my $frame = self.focused-frame;
  my $pane = self.focused if $frame;
  $pane.unfocus if $frame;
  my $f = self.screen.add-frame(:$height, :$width, :center);
  my ($t,$p,$msg);
  with $title {
    ($t,$msg,$p) = $f.add-panes(heights => [ 1, fr => 1, 1 ]);
    $t.name = 'alert-title';
    $p.name = 'alert-body';
    $t.put: $title, :center;
    $t.focusable = False;
  } else {
    ($msg,$p) = $f.add-panes(heights => [fr => 1, 1]);
    $p.name = 'alert';
  }
  $msg.focusable = False;
  $msg.put(" $_ ",:$center) for @lines;
  $p.put(" ok ", :center, :meta(:value<ok>));
  my $promise = Promise.new;
  $p.on: select => -> :%meta { $promise.keep(%meta) };
  $f.draw;
  self.focus($f, pane => $p);
  $p.select-visible($p.height - 1);
  info "waiting for alert";
  $.lock-focus = True;
  my $res = $promise.result;
  $.lock-focus = False;
  info "done waiting for alert";
  self.screen.remove-frame($f);
  self.focus($frame, :$pane) if $frame && $pane;
  self.refresh(:hard);
  $res<value>;
}



