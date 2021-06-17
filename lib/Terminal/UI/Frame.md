## NAME

Terminal::UI::Frame -- A border, which may have several panes

## DESCRIPTION

A frame is like a window frame -- it represents the border, and may have several panes within it.

### ATTRIBUTES

* **$!focused** (Terminal::UI::Pane)

  The focused pane

* **$!height** (Terminal::UI::Frame::UInt)

  Number of rows, including the top and bottom borders

* **$!height-computer** (Mu)

  A function to compute an array of heights of panes, given the screen height.

* **$!left** (Terminal::UI::Frame::UInt)

  Offset from the left of the screen. A maximized frame has left == 1.

* **$!name** (Mu)

  A name for this frame (optional)

* **$!number-of-dividers** (Mu)

  Number of dividers. Will be number of panes - 1, when panes are added.

* **$!screen** (Mu)

  The screen associated with the frame.

* **$!top** (Terminal::UI::Frame::UInt)

  Offset from the top of the screen. A maximized frame has top == 1.

* **$!width** (Terminal::UI::Frame::UInt)

  Number of columns

* **%!border** (Associative)

  Characters for drawing the frame border.

* **@!dividers** (Positional[Terminal::UI::Frame::UInt])

  List of rows with dividers in the frame.

* **@!panes** (Positional[Terminal::UI::Pane])

  The panes for the frame.


### METHODS

* [**add-divider**(Terminal::UI::Frame: Int $line where { ... }, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L63)

  Add a divider to the frame at the given row (between 1 and height)

* [**add-pane**(Terminal::UI::Frame: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L125)

  Create a single pane for this frame

* [**add-panes**(Terminal::UI::Frame: :$ratios!, :$height-computer, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L134)

  Add multiple panes with the given height ratios

* [**add-panes**(Terminal::UI::Frame: :$heights! is copy, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L179)

  Add multiple panes with the given heights, and optionally a callback for computing heights

* [**available-rows**(Terminal::UI::Frame: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L207)

  Number of available rows: height - 2 - (number of dividers - 1)

* [**bottom**(Terminal::UI::Frame: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L53)

  The row of the bottom (top + height - 1)

* [**check**(Terminal::UI::Frame: @panes, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L69)

  Validate that the heights of the panes + the dividers add up

* [**draw**(Terminal::UI::Frame: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L93)

  Draw or refresh this frame

* [**draw-side**(Terminal::UI::Frame: $h, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L112)

  Draw only the sides, of a particular row

* [**focus**(Terminal::UI::Frame: Terminal::UI::Pane $pane, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L215)

  Change focus to a particular pane in this frame

* [**handle-resize**(Terminal::UI::Frame: :$from-width, :$from-height, :$to-width, :$to-height, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L228)

  Handle a resize of the screen

* [**pane**(Terminal::UI::Frame: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L260)

  If there is only one pane, return it.

* [**print-line**(Terminal::UI::Frame: $h, $str, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L118)

  Print a single line of output in the frame, including the borders.

* [**right**(Terminal::UI::Frame: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.18/lib/Terminal/UI/Frame.rakumod#L58)

  The rightmost column (left + width - 1)
