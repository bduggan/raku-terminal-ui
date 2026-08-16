## NAME

Terminal::UI::Pane -- An area that contains scrollable text

## DESCRIPTION

A pane is a text area that can scroll. It also has as registry of actions, which may be referenced by name.

### ATTRIBUTES

* **$!auto-scroll** (Bool)

  Scroll automatically when putting a new line?

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

* **$!selectable** (Bool)

  Can lines be selected?

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

* [**bottom**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L85)

  Absolute bottom (top + height)

* [**call**(Terminal::UI::Pane $:: $name, :$arg, Bool :$maybe, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L901)

  Run the action with the given name

* [**clear**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L863)

  Clear the content and redraw

* colors

  Handled by $!style

* [**current-line-index**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L119)

  The index of the current line

* [**current-meta**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L113)

  Metadata associated with the current line

* [**disable-selection**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L193)

  Disable selecting of lines within a pane

* [**draw**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L321)

  Same as redraw

* [**draw-selected-line**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L130)

  Draw the currently selected line

* [**enable-selection**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L199)

  Enable selecting of lines within a pane

* [**exec**(Terminal::UI::Pane $:: @cmd, :$filter, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L930)

  Run a shell command, and send the lines of the output to this pane, optionally filtering the output

* [**focus**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L844)

  Focus on this pane

* [**last-visible**(Terminal::UI::Pane $:: Bool :$with-content = Bool::False, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L233)

  Index of the bottom line which is visible (first-visible + height - 1)

* [**on**(Terminal::UI::Pane $:: *%kv)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L877)

  Associate callbacks with events

* [**on**(Terminal::UI::Pane $:: Str :$name!, Callable :$action!, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L884)

  Associate a callback, with the name of an action

* [**on-sync**(Terminal::UI::Pane $:: Str :$name!, Callable :$action!, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L895)

  Associate a synchronous callback, with the name of an action

* [**page-down**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L281)

  Select down by the number of lines in the pane

* [**page-up**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L286)

  Select up by the number of lines in the pane

* [**print**(Terminal::UI::Pane $:: Str $str, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L459)

  Print a raw string to the terminal

* [**put**(Terminal::UI::Pane $:: $content, Bool :$scroll-ok = Code.new, Bool :$center, :%meta, Str :$wrap where { ... } = "none", *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L616)

  Add lines of content, possibly scrolling. Content is added one line at a time -- the content can be any type that has a 'lines' method.

* [**put**(Terminal::UI::Pane $:: @args, Bool :$scroll-ok = Code.new, :%meta, Str :$wrap where { ... } = "none", Bool :$center, Int :$indent = 0, Int :$hang = 0, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L804)

  Put formatted text. Each element is either a string or a pair. Strings are printed. Keys of pairs are printed, and then their values. Keys are assumed to be formatting, and do not count towards the length of the line. :indent puts left padding on every wrapped line; :hang adds extra padding on continuation lines only (eg. to align wrapped text under the text after a bullet, rather than under the bullet itself).

* [**redraw**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L326)

  Refresh the screen

* [**right**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L88)

  Absolute right column (left + width)

* screen

  Handled by $!frame

* [**scroll-down**(Terminal::UI::Pane $:: Int :$lines = 1, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L370)

  Scroll the visible contents down. Optionally limit scrolling based on the contents.

* [**scroll-up**(Terminal::UI::Pane $:: Bool :$limit = Bool::True, Int :$lines = 1, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L339)

  Scroll the visible contents up. Optionally limit scrolling based on the contents.

* [**select**(Terminal::UI::Pane $:: $line, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L204)

  Select an index in the content.

* [**select-down**(Terminal::UI::Pane $:: $n = 1, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L259)

  Select the line $n lines below the current one, possibly scrolling the screen up

* [**select-down_10**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L271)

  Move the selector down 10 rows

* [**select-first**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L161)

  Select the first row of content

* [**select-first-visible**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L178)

  Select the last visible row.

* [**select-last**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L167)

  Select the last row of content

* [**select-last-visible**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L173)

  Select the last visible row.

* [**select-up**(Terminal::UI::Pane $:: $n = 1, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L239)

  Select the line $n above the current one, possibly scrolling the screen down

* [**select-up_10**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L276)

  Move the selector up 10 rows

* [**select-visible**(Terminal::UI::Pane $:: Int $r, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L153)

  Select a visible row. (0 is the top row)

* [**selected-row**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L401)

  Selected row, in the range 1..$!height

* [**set-size**(Terminal::UI::Pane $:: $!width, $!height, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L97)

  Change the size

* [**set-top**(Terminal::UI::Pane $:: $!top, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L110)

  Change the offset from the top

* [**splash**(Terminal::UI::Pane $:: @content, :$center = Bool::True, :$title, :$top is copy, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L414)

  Clear and add content centered vertically and horizontally

* [**splash**(Terminal::UI::Pane $:: $content, :$center = Bool::True, :$title, :$top, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L424)

  Clear and add content centered vertically and horizontally

* [**stream**(Terminal::UI::Pane $:: Supply $supply, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L554)

  Stream data from a Supply to the pane, parsing ANSI sequences

* [**unfocus**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L855)

  Remove focus from this pane

* [**update**(Terminal::UI::Pane $:: $content, Int :$line!, Bool :$center, :%meta, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.4/lib/Terminal/UI/Pane.rakumod#L433)

  Update a line of content
