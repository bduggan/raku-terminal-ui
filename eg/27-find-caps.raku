#!/usr/bin/env raku

use Terminal::UI 'ui';
use Terminal::ANSI::OO 't';

ui.setup: heights => [ fr => 1, 5 ];
my (\top,\bottom) = ui.panes;
top.auto-scroll = False;

my $file = qx[man -w terminfo].trim;
my @terminfo = $file.ends-with('.gz') ?? qqx[gzcat $file].lines !! $file.IO.lines;

sub find-cap($cap,$seq) {
  my ($line,$str) = @terminfo.grep: :kv, /^^ [\S+] \t $cap \t /;
  return unless $line;
  my $name = $str.split("\t")[0];
  my $desc = @terminfo[$line + 1];
  top.put: [
             t.yellow => $cap.fmt('%-5s '),
             t.green => $name.fmt('%-23s '),
             t.white => $desc.fmt('%-50s '),
             t.cyan => ($seq || "")
           ] ;
}

my $caps = qx[infocmp];
my @lines = $caps.lines;
bottom.put(@lines.shift) while @lines[0].starts-with('#');
bottom.put(@lines.shift) while not @lines[0].contains(',');

my @caps = @lines.map(*.trim).join.split(',');

for @caps -> $c {
  my ($cap-code,$seq) = $c.trim.split('=');
  find-cap($cap-code.trim, $seq);
}


ui.interact;
ui.shutdown;

