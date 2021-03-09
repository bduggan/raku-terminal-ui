use OO::Monitors;
unit monitor Terminal::UI::Input;
use Terminal::UI::Utils;
use Terminal::ANSI;
use Log::Async;

logger.untapped-ok = True;
method pod { $=pod }

#| TTY from which we are reading input
has $.tty;

method !maybe-init {
  return False unless $*IN.t;
  self.init without $!tty;
  return True;
}

#| Initialize input (called implicity if necessary)
method init {
  shell "stty raw -echo -icanon min 1 time 1";
  $!tty = open("/dev/tty");
}

#| Stop reading from the tty, and reset things
method shutdown {
  .close with $!tty;
  shell "stty sane";
  $!tty = Nil;
}

#| Get a single key, and optionally debug the bytes into a character.  Escape sequences are parsed by Terminal::ANSI::parse-input.
method get-key(Bool :$decode = True) {
  self!maybe-init or return;
  my $got = try $!tty.read(10);
  abort "$!" if $!;
  return $got unless $decode;
  my $c = $got.decode;
  return parse-input($c) // $c;
}

=NAME Terminal::UI::Input -- Keyboard input

=begin DESCRIPTION

Get keyboard input.

=end DESCRIPTION

