## NAME

Terminal::UI::Input -- Keyboard input

## DESCRIPTION

Get keyboard input.

### ATTRIBUTES

* **$!tty** (Mu)

  TTY from which we are reading input


### METHODS

* [**get-key**(Terminal::UI::Input: Bool :$decode = Bool::True, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Input.rakumod#L27)

  Get a single key, and optionally debug the bytes into a character. Escape sequences are parsed by Terminal::ANSI::parse-input.

* [**init**(Terminal::UI::Input: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Input.rakumod#L15)

  Initialize input (called implicity if necessary)

* [**shutdown**(Terminal::UI::Input: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Input.rakumod#L21)

  Stop reading from the tty, and reset things
