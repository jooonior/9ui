// Expandable side panel containing gamemode selection buttons. Expands when 
// the play button is clicked.
//
// Creation deferred until first expanded.
// ---
// parent: MainMenuOverride => ./MainMenuOverride.res


// Stock file contains:
//   #base "MatchMakingDashboardSidePanel.res"

"Resource/UI/MatchMakingDashboardPlayList.res"
{
  ExpandableList
  {
    xPos r0  // hardcoded to transition between `r0` and `rs1`
    yPos 0
    zPos "$(zPos.ExpandableList)"
    tall "$(PlaylistEntry.Height)"
    // Much wider than the screen to exploit the xPos transition for sliding a
    // gradient across the screen, creating a fade effect. The gradient lies
    // inside `ExplanationManager`, which is pinned to us (for z-order reasons).
    wide "f-$(ExpandableList.Overflow + ExpandableList.Width)"
    proportionalToParent 0

    // Offset xPos so that only the left-most part slides on-screen.
    // `MMDashboard` dimensions are set specifically for this purpose.
    {EXPAND Pin MMDashboard $(PIN_TOPLEFT) $(PIN_BOTTOMRIGHT)}
    // Pin is not updated after a VGUI reload, which means that the anchor must
    // not be invalidated by said reload (as `MainMenuOverride.res` panels are).
  }

  {DELETE
    Title
    PlayListDropShadow
  }

  playlist
  {
    xPos 0
    yPos 0
    zPos 0
    wide "$(PlaylistEntry.Width * PlaylistEntry.Count)"
    tall f0
    proportionalToParent 1

    // => ./MatchMakingPlaylist.res
  }

  // Covers up `playlist` when one of the matchmaking side panels is open.
  // Closes all open matchmaking side panels when clicked.
  ReturnButton
  {
    {INHERIT ../playlist
      xPos
      yPos
      wide
      tall
      proportionalToParent
    }

    zPos "$(../playlist/zPos + 1)"

    alpha 0
    visible 0  // toggled from code when "child" panel is expanded/collapsed

    // Mouse down closes the open "child" panel, which sets us invisible and
    // lets the buttons in `playlist` catch the mouse up (ACTIVATE_ONRELEASED).
    button_activation_type "$(ACTIVATE_ONPRESSED)"
  }

  // Closes `ExpandableList` and all open matchmaking side panels.
  CloseButton2
  {
    {EXPAND FlatButton}

    tall f0
    wide "$(ExpandableList.Width - ../playlist/wide)"
    proportionalToParent 1

    {EXPAND PinRightTo playlist}

    font 9ui.icons.10
    labelText "$(ICON_RIGHT)"

    command "nav_close"
  }
}
