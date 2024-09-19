{PRAGMA FLAGS expand override}

"Resource/UI/MenuSideBars.res"
{
  // Z-order layout requires that each sidebar is cut into two panels. The top,
  // which sits under `MMDashboard`, needs to have a lower zPos than the rest.

  {DEFINE SideBar} {
    controlName Panel

    yPos "$(Menu.SideBar.Width)"
    zPos "$(zPos.MainMenu - 10)"  // below menu buttons, above `ExpandableList`

    wide "$(Menu.SideBar.Width)"
    tall "f$(Menu.SideBar.Width)"

    bgColor_override _9ui.SideBar.BG

    mouseInputEnabled 0
  }

  SideBar.Left
  {
    {EXPAND SideBar}

    xPos 0
  }

  SideBar.Right
  {
    {EXPAND SideBar}

    xPos rs1
  }

  {DEFINE SideBar.Top} {
    {EXPAND SideBar}

    yPos 0
    zPos "$(zPos.MMDashboard - 10)"  // below `MMDashboard`

    tall "$(Menu.SideBar.Width)"
  }

  SideBar.TopLeft
  {
    {EXPAND SideBar.Top}

    xPos 0
  }

  SideBar.TopRight
  {
    {EXPAND SideBar.Top}

    xPos rs1
  }

}
