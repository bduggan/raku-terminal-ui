## NAME

Terminal::UI::Screen -- The entire screen.

## DESCRIPTION

This class represents the screen, which may have frames on it, and the frames may have panes.

### ATTRIBUTES

* **$!cols** (Mu)

  no docs

* **$!frames** (SetHash)

  no docs

* **$!resized** (Supplier)

  no docs

* **$!rows** (Mu)

  no docs


### METHODS

* **add-frame** (Terminal::UI::Screen: :$top = 1, :$left = 1, :$width = Code.new, :$height = Code.new, :$name = Code.new, Bool :$center, *%_ --> Terminal::UI::Frame)
  Add a frame to the screen.

* **draw** (Terminal::UI::Screen: *%_)
  Draw the entire screen

* **find-frame** (Terminal::UI::Screen: $name, *%_ --> Terminal::UI::Frame)
  Find a frame that has a given name

* **handle-resize** (Terminal::UI::Screen: |args)
  Handle a resize of the screen (e.g. a SIGWINCH)

* **init** (Terminal::UI::Screen: *%_)
  Clear and set things up.

* **pane** (Terminal::UI::Screen: *%_)
  When there is only one pane and only one frame, return it

* **pane-count** (Terminal::UI::Screen: :$min, :$max, *%_)
  Find the number of panes which have lines between two rows

* **panes** (Terminal::UI::Screen: *%_)
  All the panes in all the frames.

* **remove-frame** (Terminal::UI::Screen: Terminal::UI::Frame $f, *%_)
  Remove a frame

* **shutdown** (Terminal::UI::Screen: $msg = Nil, *%_)
  Shut down and reset the state, with an optional message
