## NAME

Terminal::UI::Pane -- An area that contains scrollable text

## DESCRIPTION

A pane is a text area that can scroll. It also has as registry of actions, which may be referenced by name.

### ATTRIBUTES

* **$!current-line** (Int)

  Index into @.lines (negative if we scrolled down): currently selected line

* **$!first-visible** (Int)

  Index into @.lines (negative if we scrolled down): first line in the pane

* **$!focusable** (Bool)

  Is it focusable?

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

* **%!actions** (Associative[Callable:D])

  A set of callable actions

* **%!sync-actions** (Associative)

  A set of callable actions which will be called synchronously

* **@!lines** (Positional)

  Lines of content: exactly what is sent to the screen (including formatting characters)

* **@!meta** (Positional)

  Metadata for each line

* **@!raw** (Positional)

  Lines of raw content: unformatted, contains arrays sent to the put method


### METHODS

* [**bottom**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L69)

  Absolute bottom (top + height)

* [**call**(Terminal::UI::Pane: $name, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L547)

  Run the action with the given name

* [**clear**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L511)

  Clear the content and redraw

* colors

  Handled by $!style

* [**current-meta**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L96)

  Metadata associated with the current line

* [**draw**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L283)

  Same as redraw

* [**draw-selected-line**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L108)

  Draw the currently selected line

* [**exec**(Terminal::UI::Pane: @cmd, :$filter, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L573)

  Run a shell command, and send the lines of the output to this pane, optionally filtering the output

* [**focus**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L492)

  Focus on this pane

* [**last-visible**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L197)

  Index of the bottom line which is visible (first-visible + height - 1)

* [**on**(Terminal::UI::Pane: *%kv)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L523)

  Associate callbacks with events

* [**on**(Terminal::UI::Pane: Str :$name!, Callable :$action!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L530)

  Associate a callback, with the name of an action

* [**on-sync**(Terminal::UI::Pane: Str :$name!, Callable :$action!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L541)

  Associate a synchronous callback, with the name of an action

* [**page-down**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L244)

  Select down by the number of lines in the pane

* [**page-up**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L249)

  Select up by the number of lines in the pane

* [**put**(Terminal::UI::Pane: $content, Bool :$scroll-ok = Bool::True, Bool :$center, :%meta, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L415)

  Add lines of content, possibly scrolling. Content is added one line at a time -- the content can be any type that has a 'lines' method.

* [**put**(Terminal::UI::Pane: @args, Bool :$scroll-ok = Bool::True, :%meta, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L484)

  Put formatted text. Each element is either a string or a pair. Strings are printed. Keys of pairs are printed, and then their values. Keys are assumed to be formatting, and do not count towards the length of the line.

* [**redraw**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L288)

  Refresh the screen

* [**right**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L72)

  Absolute right column (left + width)

* screen

  Handled by $!frame

* [**scroll-down**(Terminal::UI::Pane: Int :$lines = 1, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L331)

  Scroll the visible contents down. Optionally limit scrolling based on the contents.

* [**scroll-up**(Terminal::UI::Pane: Bool :$limit = Bool::True, Int :$lines = 1, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L302)

  Scroll the visible contents up. Optionally limit scrolling based on the contents.

* [**select**(Terminal::UI::Pane: $line, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L169)

  Select an index in the content.

* [**select-down**(Terminal::UI::Pane: $n = 1, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L222)

  Select the line $n lines below the current one, possibly scrolling the screen up

* [**select-down_10**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L234)

  Move the selector down 10 rows

* [**select-first**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L137)

  Select the first row of content

* [**select-first-visible**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L154)

  Select the last visible row.

* [**select-last**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L143)

  Select the last row of content

* [**select-last-visible**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L149)

  Select the last visible row.

* [**select-up**(Terminal::UI::Pane: $n = 1, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L202)

  Select the line $n above the current one, possibly scrolling the screen down

* [**select-up_10**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L239)

  Move the selector up 10 rows

* [**select-visible**(Terminal::UI::Pane: Int $r, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L130)

  Select a visible row. (0 is the top row)

* [**selected-row**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L363)

  Selected row, in the range 1..$!height

* [**set-size**(Terminal::UI::Pane: $!width, $!height, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L81)

  Change the size

* [**set-top**(Terminal::UI::Pane: $!top, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L93)

  Change the offset from the top

* [**splash**(Terminal::UI::Pane: $content, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L376)

  Clear and add content centered vertically and horizontally

* [**unfocus**(Terminal::UI::Pane: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L503)

  Remove focus from this pane

* [**update**(Terminal::UI::Pane: $content, Int :$line!, Bool :$center, :%meta, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.13/lib/Terminal/UI/Pane.rakumod#L389)

  Update a line of content
