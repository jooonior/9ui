// Side bars contained in main menu and inventory root panels.
//
// base: MainMenuOverride => ./MainMenuOverride.res
// base: character_info => ./CharInfoPanel.res


"Resource/UI/MenuSideBars.res"
{
  // Z-order layout requires that each sidebar is cut into two panels. The top,
  // which sits under `MMDashboard`, needs to have a lower zPos than the rest.

  {DEFINE SideBar} {
    controlName Panel

    yPos 0
    zPos "$(zPos.Background + 10)"

    wide "$(Menu.SideBar.Width)"
    tall f0
    proportionalToParent 0

    bgColor_override _9ui.SideBar.BG

    mouseInputEnabled 0
  }

  SideBar.Left
  {
    {EXPAND SideBar}

    xPos 0
  }
}
