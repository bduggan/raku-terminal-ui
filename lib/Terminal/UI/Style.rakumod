unit class Terminal::UI::Style;

method pod { $=pod }

#| Color for the selected row, when the pane is focused and when it is not
has %.colors is rw =
  focused   => { selected => { fg => 15, bg => 22 } },
  unfocused => { selected => { fg => 15, bg => 236 } }
;

my $s;

#| Same as singleton
method new(*%named) {
  $s //= self.bless(|%named)
}

#| Get the singleton object.
method singleton {
  Terminal::UI::Style.new;
}

=NAME Terminal::UI::Style -- Global style for UI elements

=begin DESCRIPTION

This is a singleton class which keeps track of a global
style for UI elements.

=end DESCRIPTION

