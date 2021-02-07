## Terminal::UI

A framework for building terminal interfaces.

## Example

Create a box in full screen with some text in it, wait for a key, then exit:

    use Terminal::UI 'ui';
    ui.setup(:1pane);
    ui.pane.put("Hello world.");
    ui.get-key;
    ui.shutdown;

    ╔══════════════╗
    ║Hello world.  ║
    ║              ║
    ╚══════════════╝

## Example 2

Make a screen split with a line in the middle, with scrollable text on the top
and bottom, and a selected row in the top box.  The arrow keys (or j,k) move
the selected line up and down.  Tab switches to the other box.

    use Terminal::UI 'ui';
    ui.setup(:2panes);
    ui.panes[0].put("$_") for 1..10;
    ui.panes[1].put("$_") for <hello world>;
    ui.interact;
    ui.shutdown;

    ╔══════════════╗
    ║8             ║  <- selected in green, scrollable
    ║9             ║
    ║10            ║
    ╟──────────────╢
    ║hello         ║  <- selected in grey.
    ║world         ║
    ╚══════════════╝

## Example 3

Like example 2, but also -- pressing Enter in the top box
will some text about add the currently selected row to the 
bottom box:

  ui.setup(:2panes);
  ui.panes[0].put("$_") for 1..10;

  ui.panes[0].on: select => -> :$raw, :$meta {
    ui.panes[1].put("you chose $raw!")
  }

  ui.interact;
  ui.shutdown;

## Features and design goals

* Easy to quickly make a console interface with custom behavior, but practical defaults.

* Scrolling with some optimization, such as using ANSI scroll region escape sequences.

* Thread safe.  Concurrency friendly.  Unicode compatibile.

* Dynamic geometry calculation, for smart handling of window resizing.

## More examples

See the [eg](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/item/eg/) directory.

## Description

The starting point for the reference documentation is
in [Terminal::UI](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/item/lib/Terminal/UI.md).  Other classes
with documentation are:

* [Terminal::UI::Screen](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/item/lib/Terminal/UI/Screen.md)
* [Terminal::UI::Frame](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/item/lib/Terminal/UI/Frame.md)
* [Terminal::UI::Pane](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/item/lib/Terminal/UI/Pane.md)
* [Terminal::UI::Style](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/item/lib/Terminal/UI/Style.md)
* [Terminal::UI::Input](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/item/lib/Terminal/UI/Input.md)

## Author

Brian Duggan (bduggan at matatu.org)

