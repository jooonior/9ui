{PRAGMA FLAGS expand override}

"Resource/UI/MatchMakingDashboardPlayList.res"
{
  // How much `ExpandableList` extends off-screen.
  {DEFINE overflow} 10000

  ExpandableList
  {
    xPos r0
    yPos 0
    zPos 10002  // above MMDashboard
    tall f0
    wide "f-$(overflow)"
    proportionalToParent 0
  }

  {DELETE
    Title
    PlayListDropShadow
  }

  playlist
  {
    xPos "rs1-$(Menu.SideBar.Width)"
    yPos 0
  }

  CloseButton
  {
    {EXPAND FillParent}
    zPos "$(../playlist/zpos - 1)"
    alpha 0
  }

  FakeDashboardDimmer
  {
    controlName EditablePanel

    xPos 0
    yPos rs1
    wide f0
    // tall 60
    tall p0.124  // pixel-perfect
    proportionalToParent 1

    mouseInputEnabled 0

    Background_anchor
    {
      controlName Panel

      xPos rs1
      yPos 0
      tall f0
      wide 0
      proportionalToParent 1
    }

    Background
    {
      controlName Panel

      xPos 0
      yPos 0
      wide f0
      tall f0

      bgColor_override "0 0 0 230"

      {EXPAND PinLeftTo Background_anchor}
    }

    // Creates a fade effect as `ExpandableList` opens.
    Fade
    {
      controlName ImagePanel

      xPos 0
      yPos 0
      wide $(overflow)
      tall f0
      proportionalToParent 1

      image "replay/thumbnails/9ui/dashboard_dimmer_fade"
      scaleImage 1

      {EXPAND PinLeftTo Background}
    }
  }
}
