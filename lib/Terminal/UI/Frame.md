## NAME

Terminal::UI::Frame -- A border, which may have several panes

## DESCRIPTION

A frame is like a window frame -- it represents the border, and may have several panes within it.

### ATTRIBUTES

* **$!focused** (Terminal::UI::Pane)

  The focused pane

* **$!height** (Terminal::UI::Frame::UInt)

  Number of rows

* **$!height-computer** (Mu)

  A function to compute an array of heights of panes, given the screen height.

* **$!left** (Terminal::UI::Frame::UInt)

  Offset from the left of the screen. A maximized frame has left == 1.

* **$!name** (Mu)

  A name for this frame (optional)

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

* [**add-divider**(Terminal::UI::Frame: Int $line where { ... }, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Frame.rakumod#L62)

  Add a divider to the frame at the given row (between 1 and height)

* [**add-pane**(Terminal::UI::Frame: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Frame.rakumod#L113)

  Create a single pane for this frame

* [**add-panes**(Terminal::UI::Frame: :$ratios!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Frame.rakumod#L119)

  Add multiple panes with the given height ratios

* [**add-panes**(Terminal::UI::Frame: :$heights!, :$!height-computer, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Frame.rakumod#L140)

  Add multiple panes with the given heights, and optionally a callback for computing heights

* [**bottom**(Terminal::UI::Frame: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Frame.rakumod#L52)

  The row of the bottom (top + height - 1)

* [**check**(Terminal::UI::Frame: @panes, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Frame.rakumod#L68)

  Validate that the heights of the panes + the dividers add up

* [**compose-line**(Terminal::UI::Frame: $str, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Frame.rakumod#L108)

  Given a string, combine it with borders of the frame, to make a printable row

* [**draw**(Terminal::UI::Frame: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Frame.rakumod#L86)

  Draw or refresh this frame

* [**draw-side**(Terminal::UI::Frame: $h, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Frame.rakumod#L102)

  Draw only the sides, of a particular row

* [**focus**(Terminal::UI::Frame: Terminal::UI::Pane $pane, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Frame.rakumod#L155)

  Change focus to a particular pane in this frame

* [**handle-resize**(Terminal::UI::Frame: :$from-width, :$from-height, :$to-width, :$to-height, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Frame.rakumod#L168)

  Handle a resize of the screen

* [**pane**(Terminal::UI::Frame: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Frame.rakumod#L192)

  If there is only one pane, return it.

* [**right**(Terminal::UI::Frame: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI/Frame.rakumod#L57)

  The rightmost column (left + width - 1)
