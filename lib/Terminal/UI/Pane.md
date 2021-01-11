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

  Lines of content

* **@!meta** (Positional)

  Metadata for each line


### METHODS

* [**bottom**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L58)

  Absolute bottom (top + height)

* [**clear**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L303)

  Clear the content and redraw

* colors

  Handled by $!style

* [**current-meta**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L70)

  Metadata associated with the current line

* [**draw**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L214)

  Same as redraw

* [**draw-selected-line**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L80)

  Draw the currently selected line

* [**focus**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L289)

  Focus on this pane

* [**last-visible**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L131)

  Index of the bottom line which is visible (first-visible + height - 1)

* [**page-down**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L169)

  Select down by the number of lines in the pane

* [**page-up**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L174)

  Select up by the number of lines in the pane

* [**put**(Terminal::UI::Pane: $str where { ... }, Bool :$scroll-ok = Bool::True, :%meta, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L275)

  Add a line to the content. Scroll down if the last line is visible and this line would be off screen.

* [**redraw**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L219)

  Refresh the screen

* [**register-action**(Terminal::UI::Pane: Str :$name, Callable :$action, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L314)

  Associate a callback, with the name of an action

* [**right**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L61)

  Absolute right column (left + width)

* [**run-action**(Terminal::UI::Pane: $name, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L319)

  Run the action with the given name

* screen

  Handled by $!frame

* [**scroll-down**(Terminal::UI::Pane: Bool :$limit = Bool::True, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L246)

  Scroll the visible contents down. Optionally limit scrolling based on the contents.

* [**scroll-up**(Terminal::UI::Pane: Bool :$limit = Bool::True, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L230)

  Scroll the visible contents up. Optionally limit scrolling based on the contents.

* [**select**(Terminal::UI::Pane: $line is copy = Code.new, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L108)

  Select an index in the content.

* [**select-down**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L155)

  Select the line below the current one, possibly scrolling the screen up

* [**select-up**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L136)

  Select the line above the current one, possibly scrolling the screen down

* [**select-visible**(Terminal::UI::Pane: Int $r, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L102)

  Select a visible row. (0 is the top row)

* [**selected-row**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L262)

  Selected row, in the range 1..$!height

* [**set-size**(Terminal::UI::Pane: $!width, $!height, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L64)

  Change the size

* [**set-top**(Terminal::UI::Pane: $!top, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L67)

  Change the offset from the top

* [**unfocus**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Pane.rakumod#L296)

  Remove focus from this pane
