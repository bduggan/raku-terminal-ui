
use Terminal::ANSI;

save-screen;
clear-screen;
home;
set-scroll-region(2,10);
move-to(3,1);

my Proc::Async $proc .= new: :pty(:rows(8), :cols(72)), 'bash';

my $receive = $proc.stdout(:bin);

$receive.tap: -> $bytes {
   for $bytes.decode.ords {
     # print(chr($_).raku ~ "/");
     print(chr($_));
   }
}

put "--------------------";
react {
  whenever $proc.ready {
    $proc.put("ls -l");
    sleep 1;
    $proc.put("sleep 1");
    sleep 2;
    $proc.put("exit");
    sleep 1;
    #whenever $proc.print("sleep 1\nexit\n") {
    #  # say ">>>> sent sleep + exit";
    #}
  }
  whenever $proc.start {
    say "done";
  }
}
put "---------------------";
reset-scroll-region;
restore-screen;

