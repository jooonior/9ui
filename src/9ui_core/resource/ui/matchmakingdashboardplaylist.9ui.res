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
    wide 300
    tall "$(Menu.SideBar.Width)"
  }

  CloseButton
  {
    {EXPAND FillParent}
    zPos -1
    alpha 0
  }

  ReturnButton
  {
    visible 0
  }
}
