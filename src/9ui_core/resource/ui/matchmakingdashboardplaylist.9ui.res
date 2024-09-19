{PRAGMA FLAGS expand override}

"Resource/UI/MatchMakingDashboardPlayList.res"
{
  ExpandableList
  {
    xPos r0  // hardcoded to transition between `r0` and `rs1`
    yPos 0
    zPos "$(zPos.ExpandableList)"
    tall f0
    // Much wider than the screen to exploit the xPos transition for sliding a
    // gradient across the screen, creating a fade effect. The gradient lies
    // inside `ExplanationManager`, which is pinned to us (for z-order reasons).
    wide "f-$(ExpandableList.Overflow + ExpandableList.Width)"
    proportionalToParent 0

    // Offset xPos so that only the left-most part slides on-screen.
    // `MMDashboard` dimensions are set specifically for this purpose.
    {EXPAND Pin MMDashboard $(PIN_TOPLEFT) $(PIN_TOPRIGHT)}
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
    tall "$(PlaylistEntry.Height)"
  }

  // Covers up `playlist` when one of the mode "child" panels is open.
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

  // Imitates hover effect of `MMDashboard > TopBar > PlayButton`, which gets
  // covered up by the side panel when it expands.
  FakePlayButton
  {
    {EXPAND PlayButton}

    xPos "$(ExpandableList.Width)-s1"
    yPos 0
    proportionalToParent 1

    font 9ui.icons.28
    labelText "$(ICON_PLAY)"

    command "nav_close"  // close all side panels

    // Should be visible only when hovered.
    defaultFgColor_override "0 0 0 0"
  }
}
