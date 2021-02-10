use Terminal::ANSI;
use Log::Async;

sub abort($msg) is export {
  fatal("$msg");
  cursor-on;
  reset-scroll-region;
  restore-screen;
  clear-screen;
  exit unless $*OUT.t;
  shell "stty sane";
  shell "reset";
  put "aborted!";
  put $msg // '\rsomething went wrong';
  exit;
}
