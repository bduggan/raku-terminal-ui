use Terminal::ANSI;
use Log::Async;

sub abort($msg) is export {
  fatal("$msg");
  error("$_".trim) for Backtrace.new;
  cursor-on;
  reset-scroll-region;
  restore-screen;
  clear-screen;
  exit note "abort: $msg" unless $*OUT.t;
  shell "stty sane";
  shell "reset";
  put "aborted!";
  put $msg // '\rsomething went wrong';
  exit 1;
}
