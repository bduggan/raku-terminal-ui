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

* [**add-screen**(Terminal::UI: |args --> Terminal::UI::Screen)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L126)

  Add a screen to the ui. Arguments are sent to the Screen contructor

* [**draw**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L44)

  Synonym for refresh

* find-frame

  Handled by $!screen

* [**focus**(Terminal::UI: Str :$frame!, Int :$pane!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L60)

  Set a pane and frame to be focused, using the name of the frame.

* [**focus**(Terminal::UI: Str :$pane where { ... }, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L66)

  Set the next pane to be focused.

* [**focus**(Terminal::UI: Int :$pane!, Int :$frame = 0, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L74)

  Set a pane and frame to be focused, using the index of the frame.

* [**focus**(Terminal::UI: Terminal::UI::Frame $frame, Int :$pane = 0, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L81)

  Set a pane and frame to be focused, using the frame.

* [**focused**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L35)

  The currently focused pane within the currently focused frame.

* frames

  Handled by $!screen

* get-key

  Handled by $!input

* [**keys**(Terminal::UI: Str :$done, *%_ --> Supply)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L139)

  a Supply of keyboard input; ends when $done is seen.

* [**log**(Terminal::UI: Str $file, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L133)

  Starting logging to a file.

* pane

  Handled by $!screen

* panes

  Handled by $!screen

* [**refresh**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L49)

  Refresh the screen, the frames, and their panes.

* [**selected-meta**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L151)

  The current metadata for the selected pane, within the selected frame

* [**setup**(Terminal::UI: :$pane!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L88)

  Set up with a single pane

* [**setup**(Terminal::UI: :&heights!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L95)

  Set up with a callback that computes heights based on the total available height

* [**setup**(Terminal::UI: Int :$panes!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L105)

  Set up with a number of panes; evenly sized.

* [**setup**(Terminal::UI: :$ratios!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L112)

  Set up with panes that have the given ratios.

* [**shutdown**(Terminal::UI: $msg = Nil, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L120)

  Shut down the UI, and optionally emit a message.

* [**style**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.1/lib/Terminal/UI.rakumod#L156)

  The global style object
