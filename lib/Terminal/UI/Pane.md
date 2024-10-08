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

* [**bottom**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L76)

  Absolute bottom (top + height)

* [**call**(Terminal::UI::Pane $:: $name, :$arg, Bool :$maybe, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L636)

  Run the action with the given name

* [**clear**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L598)

  Clear the content and redraw

* colors

  Handled by $!style

* [**current-line-index**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L110)

  The index of the current line

* [**current-meta**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L104)

  Metadata associated with the current line

* [**disable-selection**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L184)

  Disable selecting of lines within a pane

* [**draw**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L311)

  Same as redraw

* [**draw-selected-line**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L121)

  Draw the currently selected line

* [**enable-selection**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L190)

  Enable selecting of lines within a pane

* [**exec**(Terminal::UI::Pane $:: @cmd, :$filter, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L665)

  Run a shell command, and send the lines of the output to this pane, optionally filtering the output

* [**focus**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L579)

  Focus on this pane

* [**last-visible**(Terminal::UI::Pane $:: Bool :$with-content = Bool::False, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L224)

  Index of the bottom line which is visible (first-visible + height - 1)

* [**on**(Terminal::UI::Pane $:: *%kv)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L612)

  Associate callbacks with events

* [**on**(Terminal::UI::Pane $:: Str :$name!, Callable :$action!, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L619)

  Associate a callback, with the name of an action

* [**on-sync**(Terminal::UI::Pane $:: Str :$name!, Callable :$action!, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L630)

  Associate a synchronous callback, with the name of an action

* [**page-down**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L272)

  Select down by the number of lines in the pane

* [**page-up**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L277)

  Select up by the number of lines in the pane

* [**put**(Terminal::UI::Pane $:: $content, Bool :$scroll-ok = Code.new, Bool :$center, :%meta, Str :$wrap where { ... } = "none", *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L452)

  Add lines of content, possibly scrolling. Content is added one line at a time -- the content can be any type that has a 'lines' method.

* [**put**(Terminal::UI::Pane $:: @args, Bool :$scroll-ok = Code.new, :%meta, Str :$wrap where { ... } = "none", Bool :$center, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L556)

  Put formatted text. Each element is either a string or a pair. Strings are printed. Keys of pairs are printed, and then their values. Keys are assumed to be formatting, and do not count towards the length of the line.

* [**redraw**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L316)

  Refresh the screen

* [**right**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L79)

  Absolute right column (left + width)

* screen

  Handled by $!frame

* [**scroll-down**(Terminal::UI::Pane $:: Int :$lines = 1, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L361)

  Scroll the visible contents down. Optionally limit scrolling based on the contents.

* [**scroll-up**(Terminal::UI::Pane $:: Bool :$limit = Bool::True, Int :$lines = 1, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L330)

  Scroll the visible contents up. Optionally limit scrolling based on the contents.

* [**select**(Terminal::UI::Pane $:: $line, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L195)

  Select an index in the content.

* [**select-down**(Terminal::UI::Pane $:: $n = 1, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L250)

  Select the line $n lines below the current one, possibly scrolling the screen up

* [**select-down_10**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L262)

  Move the selector down 10 rows

* [**select-first**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L152)

  Select the first row of content

* [**select-first-visible**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L169)

  Select the last visible row.

* [**select-last**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L158)

  Select the last row of content

* [**select-last-visible**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L164)

  Select the last visible row.

* [**select-up**(Terminal::UI::Pane $:: $n = 1, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L230)

  Select the line $n above the current one, possibly scrolling the screen down

* [**select-up_10**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L267)

  Move the selector up 10 rows

* [**select-visible**(Terminal::UI::Pane $:: Int $r, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L144)

  Select a visible row. (0 is the top row)

* [**selected-row**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L392)

  Selected row, in the range 1..$!height

* [**set-size**(Terminal::UI::Pane $:: $!width, $!height, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L88)

  Change the size

* [**set-top**(Terminal::UI::Pane $:: $!top, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L101)

  Change the offset from the top

* [**splash**(Terminal::UI::Pane $:: @content, :$center = Bool::True, :$title, :$top is copy, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L405)

  Clear and add content centered vertically and horizontally

* [**splash**(Terminal::UI::Pane $:: $content, :$center = Bool::True, :$title, :$top, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L415)

  Clear and add content centered vertically and horizontally

* [**unfocus**(Terminal::UI::Pane $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L590)

  Remove focus from this pane

* [**update**(Terminal::UI::Pane $:: $content, Int :$line!, Bool :$center, :%meta, *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Pane.rakumod#L424)

  Update a line of content
