## Terminal::UI

Building blocks for terminal interfaces.

## Example

    use Terminal::UI 'ui';
    ui.setup(:1pane);
    ui.pane.put("Hello world.");
    ui.get-key;
    ui.shutdown;

    ╔══════════════╗
    ║Hello world.  ║
    ║              ║
    ╚══════════════╝

## Features and design goals

* Scrolling with some optimization, such as using ANSI scroll region escape sequences.

* Thread safe.  Concurrency friendly.

* Dynamic geometry calculation, for smart handling of window resizing.

## More examples

See the [eg](https://git.sr.ht/~bduggan/raku-terminal-ui/tree/master/item/eg/) directory.

## Description

The starting point for the reference documentation is
in [Terminal::UI](lib/Terminal/UI.md).  Other classes
with documentation are:

* [Terminal::UI::Screen](lib/Terminal/UI/Screen.md)
* [Terminal::UI::Frame](lib/Terminal/UI/Frame.md)
* [Terminal::UI::Pane](lib/Terminal/UI/Pane.md)
* [Terminal::UI::Style](lib/Terminal/UI/Style.md)
* [Terminal::UI::Input](lib/Terminal/UI/Input.md)

## Author

Brian Duggan (bduggan at matatu.org)

