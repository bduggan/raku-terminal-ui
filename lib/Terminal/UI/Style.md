## NAME

Terminal::UI::Style -- Global style for UI elements

## DESCRIPTION

This is a singleton class which keeps track of a global style for UI elements.

### ATTRIBUTES

* **%!colors** (Associative)

  Color for the selected row, when the pane is focused and when it is not


### METHODS

* [**new**(Terminal::UI::Style $:: *%named)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Style.rakumod#L13)

  Same as singleton

* [**singleton**(Terminal::UI::Style $:: *%_)](https://github.com/bduggan/raku-terminal-ui/tree/0.1.3/lib/Terminal/UI/Style.rakumod#L18)

  Get the singleton object.
