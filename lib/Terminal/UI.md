## NAME

Terminal::UI -- A framework for building terminal interfaces

## DESCRIPTION

Terminal::UI is a framework for building user interfaces in the terminal.

This class provides routines for manipulating:

* a screen: the top level object representing the screen

* frames: borders around content

* panes: scrolling regions with content

* style: a global style

* input: input routines

These are documented in Terminal::UI::Screen, Frame, Pane, Style, and Input respectively.

### ATTRIBUTES

* **$!focused-frame** (Terminal::UI::Frame)

  The currently focused frame.

* **$!input** (Terminal::UI::Input)

  The object for getting input.

  Handles: **get-key**

* **$!screen** (Terminal::UI::Screen)

  The screen object, which tracks frames and panes.

  Handles: **pane**, **panes**, **frames**, **find-frame**


### METHODS

* [**add-screen**(Terminal::UI: |args --> Terminal::UI::Screen)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L129)

  Add a screen to the ui. Arguments are sent to the Screen contructor

* [**draw**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L45)

  Synonym for refresh

* find-frame

  Handled by $!screen

* [**focus**(Terminal::UI: Str :$frame!, Int :$pane!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L61)

  Set a pane and frame to be focused, using the name of the frame.

* [**focus**(Terminal::UI: Str :$pane where { ... }, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L67)

  Set the next pane to be focused.

* [**focus**(Terminal::UI: Int :$pane, Int :$frame = 0, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L77)

  Set a pane and frame to be focused, using the indexes (default 0,0).

* [**focus**(Terminal::UI: Terminal::UI::Frame $frame, Int :$pane = 0, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L84)

  Set a pane and frame to be focused, using the frame.

* [**focused**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L35)

  The currently focused pane within the currently focused frame.

* frames

  Handled by $!screen

* get-key

  Handled by $!input

* [**keys**(Terminal::UI: Str :$done, *%_ --> Supply)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L142)

  a Supply of keyboard input; ends when $done is seen.

* [**log**(Terminal::UI: Str $file, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L136)

  Starting logging to a file.

* pane

  Handled by $!screen

* panes

  Handled by $!screen

* [**refresh**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L50)

  Refresh the screen, the frames, and their panes.

* [**select-down**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L169)

  Move down one line in the selected pane of the selected frame

* [**select-up**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L164)

  Move up one line in the selected pane of the selected frame

* [**selected-meta**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L154)

  The current metadata for the selected pane, within the selected frame

* [**setup**(Terminal::UI: :$pane!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L91)

  Set up with a single pane

* [**setup**(Terminal::UI: :&heights!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L98)

  Set up with a callback that computes heights based on the total available height

* [**setup**(Terminal::UI: Int :$panes!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L108)

  Set up with a number of panes; evenly sized.

* [**setup**(Terminal::UI: :$ratios!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L115)

  Set up with panes that have the given ratios.

* [**shutdown**(Terminal::UI: $msg = Nil, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L123)

  Shut down the UI, and optionally emit a message.

* [**style**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.3/lib/Terminal/UI.rakumod#L159)

  The global style object
