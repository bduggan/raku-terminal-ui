## NAME

Terminal::UI::Pane -- An area that contains scrollable text

## DESCRIPTION

A pane is a text area that can scroll. It also has as registry of actions, which may be referenced by name.

### ATTRIBUTES

* **$!current-line** (Int)

  Index into @.lines (negative if we scrolled down): currently selected line

* **$!first-visible** (Int)

  Index into @.lines (negative if we scrolled down): first line in the pane

* **$!focused** (Bool)

  Whether this pane is currently focused

* **$!frame** (Mu)

  The frame associated with this pane

  Handles: **screen**

* **$!height** (Terminal::UI::Pane::UInt)

  Number of rows in the pane

* **$!left** (Terminal::UI::Pane::UInt)

  Absolute left edge of the pane (default: left of the frame + 1)

* **$!name** (Mu)

  Optional descriptive name

* **$!style** (Mu)

  Style singleton

  Handles: **colors**

* **$!top** (Terminal::UI::Pane::UInt)

  Absolute top of the pane (default: top of the frame + 1)

* **$!width** (Terminal::UI::Pane::UInt)

  Number of columns

* **%!actions** (Associative)

  A set of callable actions

* **@!lines** (Positional)

  Lines of content: exactly what is sent to the screen (including formatting characters)

* **@!meta** (Positional)

  Metadata for each line

* **@!raw** (Positional)

  Lines of raw content: unformatted, contains arrays sent to the put method


### METHODS

* [**bottom**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L60)

  Absolute bottom (top + height)

* [**clear**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L356)

  Clear the content and redraw

* colors

  Handled by $!style

* [**current-meta**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L87)

  Metadata associated with the current line

* [**draw**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L225)

  Same as redraw

* [**draw-selected-line**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L97)

  Draw the currently selected line

* [**focus**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L342)

  Focus on this pane

* [**last-visible**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L148)

  Index of the bottom line which is visible (first-visible + height - 1)

* [**page-down**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L186)

  Select down by the number of lines in the pane

* [**page-up**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L191)

  Select up by the number of lines in the pane

* **put**(Mu: *%_)

  no docs

* **put**(Mu: \x, *%_)

  no docs

* **put**(Mu: |)

  no docs

* [**put**(Terminal::UI::Pane: Str $str, Bool :$scroll-ok = Bool::True, :%meta, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L286)

  Add a line to the content. Scroll down if the last line is visible and this line would be off screen.

* [**put**(Terminal::UI::Pane: @args, Bool :$scroll-ok = Bool::True, :%meta, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L335)

  Put formatted text. Each element is either a string or a pair. Strings are printed. Keys of pairs are printed, and then their values. Keys are assumed to be formatting, and do not count towards the length of the line.

* [**redraw**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L230)

  Refresh the screen

* **reformat**(Terminal::UI::Pane: *%_)

  no docs

* [**register-action**(Terminal::UI::Pane: Str :$name, Callable :$action, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L367)

  Associate a callback, with the name of an action

* [**right**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L63)

  Absolute right column (left + width)

* [**run-action**(Terminal::UI::Pane: $name, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L372)

  Run the action with the given name

* screen

  Handled by $!frame

* [**scroll-down**(Terminal::UI::Pane: Bool :$limit = Bool::True, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L257)

  Scroll the visible contents down. Optionally limit scrolling based on the contents.

* [**scroll-up**(Terminal::UI::Pane: Bool :$limit = Bool::True, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L241)

  Scroll the visible contents up. Optionally limit scrolling based on the contents.

* [**select**(Terminal::UI::Pane: $line is copy = Code.new, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L125)

  Select an index in the content.

* [**select-down**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L172)

  Select the line below the current one, possibly scrolling the screen up

* [**select-up**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L153)

  Select the line above the current one, possibly scrolling the screen down

* [**select-visible**(Terminal::UI::Pane: Int $r, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L119)

  Select a visible row. (0 is the top row)

* [**selected-row**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L273)

  Selected row, in the range 1..$!height

* [**set-size**(Terminal::UI::Pane: $!width, $!height, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L72)

  Change the size

* [**set-top**(Terminal::UI::Pane: $!top, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L84)

  Change the offset from the top

* [**unfocus**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI/Pane.rakumod#L349)

  Remove focus from this pane
