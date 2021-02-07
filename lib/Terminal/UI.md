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

  Handles: **pane**, **panes**, **frames**, **frame**, **find-frame**

* **%!pane-bindings** (Associative)

  Key bindings for the focused pane

* **%!ui-bindings** (Associative[Str])

  UI bindings (not specific to a pane)


### METHODS

* [**add-screen**(Terminal::UI: |args --> Terminal::UI::Screen)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L154)

  Add a screen to the ui. Arguments are sent to the Screen contructor

* [**bind**(Terminal::UI: "pane", *%kv)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L199)

  Bind keys to events on the focused pane.

* [**bind**(Terminal::UI: *%kv)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L206)

  Bind keys to UI events, independent of the focused pane.

* [**call**(Terminal::UI: $action, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L236)

  Call the action with the given name.

* [**draw**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L64)

  Synonym for refresh

* find-frame

  Handled by $!screen

* [**focus**(Terminal::UI: Str :$frame!, Int :$pane!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L80)

  Set a pane and frame to be focused, using the name of the frame.

* [**focus**(Terminal::UI: Str :$pane where { ... }, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L86)

  Set the next pane to be focused.

* [**focus**(Terminal::UI: Int :$pane, Int :$frame = 0, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L96)

  Set a pane and frame to be focused, using the indexes (default 0,0).

* [**focus**(Terminal::UI: Terminal::UI::Frame $frame, Int :$pane = 0, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L103)

  Set a pane and frame to be focused, using the frame.

* [**focused**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L54)

  The currently focused pane within the currently focused frame.

* frame

  Handled by $!screen

* frames

  Handled by $!screen

* get-key

  Handled by $!input

* [**interact**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L213)

  Respond to keyboard input, until we are done

* [**keys**(Terminal::UI: Str :$done, *%_ --> Supply)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L167)

  a Supply of keyboard input; ends when $done is seen.

* [**log**(Terminal::UI: Str $file, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L161)

  Starting logging to a file.

* [**on**(Terminal::UI: *%actions)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L229)

  Associate names of actions with callables.

* pane

  Handled by $!screen

* panes

  Handled by $!screen

* [**refresh**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L69)

  Refresh the screen, the frames, and their panes.

* [**select-down**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L194)

  Move down one line in the selected pane of the selected frame

* [**select-up**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L189)

  Move up one line in the selected pane of the selected frame

* [**selected-meta**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L179)

  The current metadata for the selected pane, within the selected frame

* [**setup**(Terminal::UI: :$pane!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L110)

  Set up with a single pane

* [**setup**(Terminal::UI: :&heights!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L117)

  Set up with a callback with one frame that computes heights based on the total available height

* [**setup**(Terminal::UI: Int :$panes!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L133)

  Set up with a number of panes; evenly sized.

* [**setup**(Terminal::UI: :$ratios!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L140)

  Set up with panes that have the given ratios.

* [**shutdown**(Terminal::UI: $msg = Nil, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L148)

  Shut down the UI, and optionally emit a message.

* [**style**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.4/lib/Terminal/UI.rakumod#L184)

  The global style object
