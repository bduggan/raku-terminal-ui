## Terminal::UI

A set of building blocks for terminal interfaces.

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

## More examples

See the [eg](eg/) directory.

## Description

The starting point for the reference documentation is
in [Terminal::UI][Terminal/UI.md].  Other classes
with documentation are:

* [Terminal::UI::Screen](lib/Terminal/UI/Screen.md)
* [Terminal::UI::Frame](lib/Terminal/UI/Frame.md)
* [Terminal::UI::Pane](lib/Terminal/UI/Pane.md)
* [Terminal::UI::Style](lib/Terminal/UI/Style.md)
* [Terminal::UI::Input](lib/Terminal/UI/Input.md)

## Author

Brian Duggan (bduggan at matatu.org)

