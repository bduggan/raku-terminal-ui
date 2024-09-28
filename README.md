 [![Actions Status](https://github.com/bduggan/raku-terminal-ui/actions/workflows/linux.yml/badge.svg)](https://github.com/bduggan/raku-terminal-ui/actions/workflows/linux.yml)
 [![Actions Status](https://github.com/bduggan/raku-terminal-ui/actions/workflows/macos.yml/badge.svg)](https://github.com/bduggan/raku-terminal-ui/actions/workflows/macos.yml)

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

    ╔══════════════╗
    ║8             ║  <- press Enter, and…
    ║9             ║
    ║10            ║
    ╟──────────────╢
    ║you chose 8!  ║  <- …this appears!
    ║              ║
    ╚══════════════╝


## Features and design goals

* Easy to quickly make a console interface with custom behavior, but practical defaults.

* Scrolling with some optimization, such as using ANSI scroll region escape sequences.

* Thread safe.  Concurrency friendly.  Unicode compatibile.

* Dynamic geometry calculation, for smart handling of window resizing.

## More examples

See the [eg](https://github.com/bduggan/raku-terminal-ui/blob/master/eg/) directory.

## See also

[https://blog.matatu.org/terminal-ui](https://blog.matatu.org/terminal-ui)

## Description

The best place for documentation is the
[examples](https://github.com/bduggan/raku-terminal-ui/blob/master/eg/) directory.

There is also reference documentation with links to the source code -- see
[Terminal::UI](https://github.com/bduggan/raku-terminal-ui/blob/master/lib/Terminal/UI.md).  Other classes
with documentation are:

* [Terminal::UI::Screen](https://github.com/bduggan/raku-terminal-ui/blob/master/lib/Terminal/UI/Screen.md)
* [Terminal::UI::Frame](https://github.com/bduggan/raku-terminal-ui/blob/master/lib/Terminal/UI/Frame.md)
* [Terminal::UI::Pane](https://github.com/bduggan/raku-terminal-ui/blob/master/lib/Terminal/UI/Pane.md)
* [Terminal::UI::Style](https://github.com/bduggan/raku-terminal-ui/blob/master/lib/Terminal/UI/Style.md)
* [Terminal::UI::Input](https://github.com/bduggan/raku-terminal-ui/blob/master/lib/Terminal/UI/Input.md)

## BUGS

Probably!

If you find some bugs, or just have something to say, feel free to contact the author.

## Author

Brian Duggan (bduggan at matatu.org)

