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

* [**add-frame**(Terminal::UI::Screen: :$top = 1, :$left = 1, :$width = Code.new, :$height = Code.new, :$name = Code.new, Bool :$center, *%_ --> Terminal::UI::Frame)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.7/lib/Terminal/UI/Screen.rakumod#L106)

  Add a frame to the screen.

* [**available-rows**(Terminal::UI::Screen: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.7/lib/Terminal/UI/Screen.rakumod#L33)

  Number of rows available (height - 2 for the border)

* [**draw**(Terminal::UI::Screen: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.7/lib/Terminal/UI/Screen.rakumod#L82)

  Draw the entire screen

* [**find-frame**(Terminal::UI::Screen: $name, *%_ --> Terminal::UI::Frame)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.7/lib/Terminal/UI/Screen.rakumod#L129)

  Find a frame that has a given name

* [**frame**(Terminal::UI::Screen: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.7/lib/Terminal/UI/Screen.rakumod#L38)

  The first frame (handy if it's the only one)

* [**handle-resize**(Terminal::UI::Screen: |args)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.7/lib/Terminal/UI/Screen.rakumod#L75)

  Handle a resize of the screen (e.g. a SIGWINCH)

* [**init**(Terminal::UI::Screen: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.7/lib/Terminal/UI/Screen.rakumod#L60)

  Clear and set things up.

* [**pane**(Terminal::UI::Screen: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.7/lib/Terminal/UI/Screen.rakumod#L150)

  When there is only one pane and only one frame, return it

* [**pane-count**(Terminal::UI::Screen: :$min, :$max, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.7/lib/Terminal/UI/Screen.rakumod#L134)

  Find the number of panes which have lines between two rows

* [**panes**(Terminal::UI::Screen: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.7/lib/Terminal/UI/Screen.rakumod#L159)

  All the panes in all the frames.

* [**refresh**(Terminal::UI::Screen: *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.7/lib/Terminal/UI/Screen.rakumod#L68)

  Refresh

* [**remove-frame**(Terminal::UI::Screen: Terminal::UI::Frame $f, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.7/lib/Terminal/UI/Screen.rakumod#L166)

  Remove a frame

* [**shutdown**(Terminal::UI::Screen: $msg = Nil, *%_)](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/0.0.7/lib/Terminal/UI/Screen.rakumod#L92)

  Shut down and reset the state, with an optional message
