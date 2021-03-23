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

* **$!interacting** (Bool)

  The UI is in an interact loop

* **$!lock-focus** (Bool)

  Lock the focus

* **$!screen** (Terminal::UI::Screen)

  The screen object, which tracks frames and panes.

  Handles: **pane**, **panes**, **frames**, **frame**, **find-frame**

* **%!pane-bindings** (Associative)

  Key bindings for the focused pane

* **%!ui-actions** (Associative)

  Actions associated with bindings.

* **%!ui-bindings** (Associative[Str])

  UI bindings (not specific to a pane)

* **%!ui-sync-actions** (Associative)

  Synchronous actions associated with bindings.


### METHODS

* [**add-screen**(Terminal::UI: |args --> Terminal::UI::Screen)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L193)

  Add a screen to the ui. Arguments are sent to the Screen contructor

* [**alert**(Terminal::UI: @lines, Int :$pad = 0, Bool :$center = Bool::True, Bool :$center-values = Bool::True, Str :$title, :@values = Code.new, :@meta, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI/Alerts.rakumod#L14)

  Show an alert box, and wait for a key press to dismiss it.

* [**bind**(Terminal::UI: "pane", :$name, *%kv)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L239)

  Bind keys to events on the focused pane.

* [**bind**(Terminal::UI: *%kv)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L255)

  Bind keys to UI events, independent of the focused pane.

* [**call**(Terminal::UI: Str $action, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L323)

  Call the action with the given name.

* [**draw**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L85)

  Synonym for refresh

* find-frame

  Handled by $!screen

* [**focus**(Terminal::UI: Str :$frame!, Int :$pane!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L102)

  Set a pane and frame to be focused, using the name of the frame.

* [**focus**(Terminal::UI: Str :$pane where { ... }, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L109)

  Set the next pane to be focused.

* [**focus**(Terminal::UI: Int :$pane, Int :$frame = 0, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L120)

  Set a pane and frame to be focused, using the indexes (default 0,0).

* [**focus**(Terminal::UI: Terminal::UI::Frame $frame, Int :$pane = 0, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L128)

  Set a pane and frame to be focused, using the frame.

* [**focus**(Terminal::UI: Terminal::UI::Frame $frame, Terminal::UI::Pane :$pane!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L136)

  Set a pane and frame to be focused, using the frame.

* [**focused**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L75)

  The currently focused pane within the currently focused frame.

* frame

  Handled by $!screen

* frames

  Handled by $!screen

* get-key

  Handled by $!input

* [**help-text**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L348)

  Auto generated help text, based on bindings

* [**interact**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L279)

  Respond to keyboard input, until we are done

* [**keys**(Terminal::UI: Str :$done, *%_ --> Supply)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L207)

  a Supply of keyboard input; ends when $done is seen.

* [**log**(Terminal::UI: Str $file, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L201)

  Starting logging to a file.

* [**on**(Terminal::UI: *%actions)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L300)

  Associate names of actions with callables.

* [**on-sync**(Terminal::UI: *%actions)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L311)

  Associate names of actions with synchronous callables.

* pane

  Handled by $!screen

* panes

  Handled by $!screen

* [**quietly**(Terminal::UI: &code, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L343)

  Suppress warnings and run code

* [**refresh**(Terminal::UI: Bool :$hard, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L90)

  Refresh the screen, the frames, and their panes.

* [**select-down**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L234)

  Move down one line in the selected pane of the selected frame

* [**select-up**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L229)

  Move up one line in the selected pane of the selected frame

* [**selected-meta**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L219)

  The current metadata for the selected pane, within the selected frame

* [**setup**(Terminal::UI: :$pane!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L143)

  Set up with a single pane

* [**setup**(Terminal::UI: Callable :&heights!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L156)

  Set up with a callback with one frame that computes heights based on the total available height

* [**setup**(Terminal::UI: Int :$panes!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L172)

  Set up with a number of panes; evenly sized.

* [**setup**(Terminal::UI: :$ratios!, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L179)

  Set up with panes that have the given ratios.

* [**shutdown**(Terminal::UI: $msg = Nil, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L187)

  Shut down the UI, and optionally emit a message.

* [**style**(Terminal::UI: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.12/lib/Terminal/UI.rakumod#L224)

  The global style object
