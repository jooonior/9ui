{PRAGMA FLAGS expand override}

"Resource/UI/MatchMakingDashboard.res"
{
  MMDashboard
  {
    xPos 0
    yPos 0
    zPos 900
    wide f0
    tall $(Menu.SideBar.Width)

    collapsed_height 0
    expanded_height $(./tall)
    resize_time 0
  }

  TopBar
  {
    xPos 0
    yPos 0
    wide f0
    tall f0
    proportionalToParent 1

    {DELETE
      Gradient
      BGPanel
      OuterShadow
    }

    QuitButton
    {
      xPos r0
      yPos 0
      wide 0
      tall 0
      proportionalToParent 1
    }

    FindAGameButton  // hardcoded
    {
      // Hardcoded to slide off-screen when `ExpandableList` opens.
      // We don't want that, so we hide this button and create our own.
      visible 0
    }

    FindAGameButton2
    {
      {EXPAND SideBarButton}

      {INHERIT ../FindAGameButton
        command
        actionSignalLevel
      }

      xPos rs1
      proportionalToParent 1

      font 9ui.icons.28
      labelText "$(ICON_PLAY)"

      // After a VGUI reload, this color is used initially.
      fgColor "$(./defaultFgColor_override)"
    }
  }
}
