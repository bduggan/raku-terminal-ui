use Terminal::ANSI;
use Log::Async;

sub abort($msg, @trace = ()) is export {
  fatal("$msg");
  error("$_") for @trace;
  debug "$_".trim for $msg.?backtrace // Backtrace.new;
  cursor-on;
  reset-scroll-region;
  restore-screen;
  clear-screen;
  exit note "abort: $msg" unless $*OUT.t;
  shell "stty sane";
  shell "reset";
  put "aborted!";
  put $msg // '\rsomething went wrong';
  put $_ for @trace;
  exit 1;
}
