## NAME

Terminal::UI::Style -- Global style for UI elements

## DESCRIPTION

This is a singleton class which keeps track of a global style for UI elements.

### ATTRIBUTES

* **%!colors** (Associative)

  Color for the selected row, when the pane is focused and when it is not


### METHODS

* **new** (Terminal::UI::Style: *%named)
  Same as singleton

* **singleton** (Terminal::UI::Style: *%_)
  Get the singleton object.
