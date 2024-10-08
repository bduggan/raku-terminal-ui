## NAME

Terminal::UI::Input -- Keyboard input

## DESCRIPTION

Get keyboard input.

### ATTRIBUTES

* **$!tty** (Mu)

  TTY from which we are reading input


### METHODS

* [**get-key**(Terminal::UI::Input $:: Bool :$decode = Bool::True, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Input.rakumod#L32)

  Get a single key, and optionally debug the bytes into a character. Escape sequences are parsed by Terminal::ANSI::parse-input.

* [**init**(Terminal::UI::Input $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Input.rakumod#L19)

  Initialize input (called implicity if necessary)

* [**shutdown**(Terminal::UI::Input $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Input.rakumod#L25)

  Stop reading from the tty, and reset things
