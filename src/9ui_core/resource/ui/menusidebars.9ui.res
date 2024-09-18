{PRAGMA FLAGS expand override}

"Resource/UI/MenuSideBars.res"
{
  {DEFINE SideBar} {
    controlName Panel

    yPos 0
    zPos "$(zPos.MainMenu - 10)"

    wide $(Menu.SideBar.Width)
    tall 480

    bgColor_override _9ui.SideBar.BG
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
}
