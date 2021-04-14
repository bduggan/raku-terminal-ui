use Terminal::UI 'ui';
use Terminal::ANSI::OO 't';
use Color;

ui.setup(:1pane);

my $d = Color.new('#ffff00');

my @row;

for 1..360 {
  my $c = $d.clone;
  for 0..ui.screen.cols {
    $c = $c.rotate(1);
    @row.push: t.bg-color(|$c.rgb) => " ";
  }
  ui.panes[0].put: @row;
  @row = ();
  $d = $d.rotate(1);
}

ui.shutdown;


