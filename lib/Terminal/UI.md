## NAME

Terminal::UI -- A framework for making terminal based user interfaces

## DESCRIPTION

Terminal::UI is a framework for generating user interfaces in the terminal.

It provides building blocks for layouts of scrolling text in the screen, and borders to divide up the screen. It also provides keyboard input routines.

At a high level: a screen has frames, which have panes. These are represented by Terminal::UI::Screen, ::Frame, and ::Pane classes. Input comes from via Terminal::UI::Input.

The UI class exports these classes, and also provide convenient routines for manipulating them.

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

* [**add-screen**(Terminal::UI: |args --> Terminal::UI::Screen)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L127)

  Add a screen to the ui. Arguments are sent to the Screen contructor

* [**draw**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L45)

  Synonym for refresh

* find-frame

  Handled by $!screen

* [**focus**(Terminal::UI: Str :$frame!, Int :$pane!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L61)

  Set a pane and frame to be focused, using the name of the frame.

* [**focus**(Terminal::UI: Str :$pane where { ... }, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L67)

  Set the next pane to be focused.

* [**focus**(Terminal::UI: Int :$pane!, Int :$frame = 0, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L75)

  Set a pane and frame to be focused, using the index of the frame.

* [**focus**(Terminal::UI: Terminal::UI::Frame $frame, Int :$pane = 0, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L82)

  Set a pane and frame to be focused, using the frame.

* [**focused**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L36)

  The currently focused pane within the currently focused frame.

* frames

  Handled by $!screen

* get-key

  Handled by $!input

* [**keys**(Terminal::UI: Str :$done, *%_ --> Supply)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L140)

  a Supply of keyboard input; ends when $done is seen.

* [**log**(Terminal::UI: Str $file, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L134)

  Starting logging to a file.

* pane

  Handled by $!screen

* panes

  Handled by $!screen

* [**refresh**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L50)

  Refresh the screen, the frames, and their panes.

* [**selected-meta**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L152)

  The current metadata for the selected pane, within the selected frame

* [**setup**(Terminal::UI: :$pane!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L89)

  Set up with a single pane

* [**setup**(Terminal::UI: :&heights!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L96)

  Set up with a callback that computes heights based on the total available height

* [**setup**(Terminal::UI: Int :$panes!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L106)

  Set up with a number of panes; evenly sized.

* [**setup**(Terminal::UI: :$ratios!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L113)

  Set up with panes that have the given ratios.

* [**shutdown**(Terminal::UI: $msg = Nil, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L121)

  Shut down the UI, and optionally emit a message.

* [**style**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/lib/Terminal/UI.rakumod#L157)

  The global style object
