## NAME

Terminal::UI::Input -- Keyboard input

## DESCRIPTION

Get keyboard input.

### ATTRIBUTES

* **$!tty** (Mu)

  TTY from which we are reading input


### METHODS

* [**get-key**(Terminal::UI::Input: Bool :$decode = Bool::True, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Input.rakumod#L28)

  Get a single key, and optionally debug the bytes into a character. Escape sequences are parsed by Terminal::ANSI::parse-input.

* [**init**(Terminal::UI::Input: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Input.rakumod#L16)

  Initialize input (called implicity if necessary)

* [**shutdown**(Terminal::UI::Input: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Input.rakumod#L22)

  Stop reading from the tty, and reset things
