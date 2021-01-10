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

* **add-screen(Terminal::UI: |args --> Terminal::UI::Screen)**
  Add a screen to the ui. Arguments are sent to the Screen contructor

* **draw(Terminal::UI: *%_)**
  Synonym for refresh

* **find-frame**
  Handled by $!screen

* **focus(Terminal::UI: Str :$frame!, Int :$pane!, *%_)**
  Set a pane and frame to be focused, using the name of the frame.

* **focus(Terminal::UI: Str :$pane where { ... }, *%_)**
  Set the next pane to be focused.

* **focus(Terminal::UI: Int :$pane!, Int :$frame = 0, *%_)**
  Set a pane and frame to be focused, using the index of the frame.

* **focus(Terminal::UI: Terminal::UI::Frame $frame, Int :$pane = 0, *%_)**
  Set a pane and frame to be focused, using the frame.

* **focused(Terminal::UI: *%_)**
  The currently focused pane within the currently focused frame.

* **frames**
  Handled by $!screen

* **get-key**
  Handled by $!input

* **keys(Terminal::UI: Str :$done, *%_ --> Supply)**
  a Supply of keyboard input; ends when $done is seen.

* **log(Terminal::UI: Str $file, *%_)**
  Starting logging to a file.

* **pane**
  Handled by $!screen

* **panes**
  Handled by $!screen

* **refresh(Terminal::UI: *%_)**
  Refresh the screen, the frames, and their panes.

* **selected-meta(Terminal::UI: *%_)**
  The current metadata for the selected pane, within the selected frame

* **setup(Terminal::UI: :$pane!, *%_)**
  Set up with a single pane

* **setup(Terminal::UI: :&heights!, *%_)**
  Set up with a callback that computes heights based on the total available height

* **setup(Terminal::UI: Int :$panes!, *%_)**
  Set up with a number of panes; evenly sized.

* **setup(Terminal::UI: :$ratios!, *%_)**
  Set up with panes that have the given ratios.

* **shutdown(Terminal::UI: $msg = Nil, *%_)**
  Shut down the UI, and optionally emit a message.

* **style(Terminal::UI: *%_)**
  The global style object
