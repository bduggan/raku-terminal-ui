use Terminal::UI 'ui';
use Terminal::ANSI::OO 't';

ui.setup(:1pane);

sub draw($k) {
  for 0..ui.screen.rows -> $i {
    my @row;
    for 0..ui.screen.cols -> $j {
      my @color = (0,0,0);
      @color[$k] = ($i + $j) min 255;
      @row.push: t.color(|@color) => "█";
    }
    ui.pane.put: @row;
  }
}

draw(0);
ui.pane.on: select => { draw((++$) mod 3) }
ui.interact;
ui.shutdown;
