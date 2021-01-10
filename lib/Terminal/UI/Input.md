## NAME

Terminal::UI::Input -- Keyboard input

## DESCRIPTION

Get keyboard input.

### ATTRIBUTES

* **$!tty** (Mu)

  TTY from which we are reading input


### METHODS

* **get-key** (Terminal::UI::Input: Bool :$decode = Bool::True, *%_)
  Get a single key, and optionally debug the bytes into a character. Escape sequences are parsed by Terminal::ANSI::parse-input.

* **init** (Terminal::UI::Input: *%_)
  Initialize input (called implicity if necessary)

* **shutdown** (Terminal::UI::Input: *%_)
  Stop reading from the tty, and reset things
