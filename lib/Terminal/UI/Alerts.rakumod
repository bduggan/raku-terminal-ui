unit role Terminal::UI::Alerts;
use Log::Async;

method pod { $=pod }

multi method select($msg, @values is copy, @meta is copy = Empty, Bool :$cancel, :$default-row) {
  if $cancel {
    @values.push: "cancel";
    @meta[ @values.elems - 1 ] = "";
  }
  self.alert($msg, :@values, :@meta, :!center, :!center-values, :$default-row);
}

multi method alert(Str $msg, Int :$pad = 0, Bool :$center = True, Bool :$center-values = True, Str :$title, :@values = ('ok',), :@meta, :$default-row) {
  self.alert($msg.lines.List, :$pad, :$center, :$title, :@values, :@meta, :$center-values, :$default-row);
}

#| Show an alert box, and wait for a key press to dismiss it.
multi method alert(@lines, Int :$pad = 0, Bool :$center = True, Bool :$center-values = True, Str :$title, :@values = ('ok',), :$default-row, :@meta) {
  my Int $width = (( ( |@lines, |@values )>>.chars.max + 4) max 16) min (self.screen.cols - 4);
  my Int $height = (3 + @lines + @values) min (self.screen.rows - 3);
  $height += 2 if $title;
  info "alert ($width x $height)";
  my $frame = self.focused-frame;
  my $pane = self.focused if $frame;
  $pane.unfocus if $frame;
  my $f = self.screen.add-frame(:$height, :$width, :center);
  my ($t,$p,$msg);
  with $title {
    ($t,$msg,$p) = $f.add-panes(heights => [ 1, fr => 1, @values.elems ]);
    $t.name = 'alert-title';
    $p.name = 'alert-body';
    $t.put: $title, :center;
    $t.focusable = False;
  } else {
    ($msg,$p) = $f.add-panes(heights => [fr => 1, @values.elems]);
    $p.name = 'alert';
  }
  $msg.focusable = False;
  $msg.put(" $_ ",:$center) for @lines;
  for @values -> $value {
    my %meta = :value(@meta[$++] // $value);
    $p.put: "$value", :center($center-values), :%meta;
  }
  my $promise = Promise.new;
  $p.on: select => -> :%meta { $promise.keep(%meta) };
  $f.draw;
  self.focus($f, pane => $p);
  $p.select-visible($default-row // ($p.height - 1));
  debug "waiting for alert";
  $.lock-focus = True;
  %.lock-interaction = <select select-up select-down> Z=> True xx *;
  my $res = $promise.result;
  $.lock-focus = False;
  %.lock-interaction = Empty;
  debug "done waiting for alert";
  self.screen.remove-frame($f);
  self.focus($frame, :$pane) if $frame && $pane;
  self.refresh(:hard);
  $res<value>;
}



