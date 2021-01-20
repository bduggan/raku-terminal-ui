## NAME

Terminal::UI::Screen -- The entire screen.

## DESCRIPTION

This class represents the screen, which may have frames on it, and the frames may have panes.

### ATTRIBUTES

* **$!cols** (Mu)

  The number of columns (default the entire screen).

* **$!frames** (SetHash)

  The frames in the screen.

* **$!resized** (Supplier)

  Resize events.

* **$!rows** (Mu)

  The number of rows (default the entire screen).


### METHODS

* [**add-frame**(Terminal::UI::Screen: :$top = 1, :$left = 1, :$width = Code.new, :$height = Code.new, :$name = Code.new, Bool :$center, *%_ --> Terminal::UI::Frame)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.2/lib/Terminal/UI/Screen.rakumod#L89)

  Add a frame to the screen.

* [**draw**(Terminal::UI::Screen: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.2/lib/Terminal/UI/Screen.rakumod#L65)

  Draw the entire screen

* [**find-frame**(Terminal::UI::Screen: $name, *%_ --> Terminal::UI::Frame)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.2/lib/Terminal/UI/Screen.rakumod#L112)

  Find a frame that has a given name

* [**handle-resize**(Terminal::UI::Screen: |args)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.2/lib/Terminal/UI/Screen.rakumod#L58)

  Handle a resize of the screen (e.g. a SIGWINCH)

* [**init**(Terminal::UI::Screen: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.2/lib/Terminal/UI/Screen.rakumod#L50)

  Clear and set things up.

* [**pane**(Terminal::UI::Screen: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.2/lib/Terminal/UI/Screen.rakumod#L133)

  When there is only one pane and only one frame, return it

* [**pane-count**(Terminal::UI::Screen: :$min, :$max, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.2/lib/Terminal/UI/Screen.rakumod#L117)

  Find the number of panes which have lines between two rows

* [**panes**(Terminal::UI::Screen: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.2/lib/Terminal/UI/Screen.rakumod#L142)

  All the panes in all the frames.

* [**remove-frame**(Terminal::UI::Screen: Terminal::UI::Frame $f, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.2/lib/Terminal/UI/Screen.rakumod#L149)

  Remove a frame

* [**shutdown**(Terminal::UI::Screen: $msg = Nil, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.2/lib/Terminal/UI/Screen.rakumod#L75)

  Shut down and reset the state, with an optional message
