{PRAGMA FLAGS expand override}

"Resource/UI/MatchMakingDashboard.res"
{
  MMDashboard
  {
    xPos 0
    yPos 0
    zPos $(zPos.MMDashboard)
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

    {EXPAND Hide QuitButton}
    {EXPAND Hide DisconnectButton}
    {EXPAND Hide ResumeButton}

    FindAGameButton_anchor
    {
      controlName Panel
      xPos 0
      yPos 0
      wide 0
      tall 0
    }

    // Move after anchor.
    {MOVE FindAGameButton}

    FindAGameButton  // hardcoded
    {
      xPos 0  // hardcoded relative to own width and xPos of `DisconnectButton`
      yPos 0  // hardcoded to transition between 0 and -49

      wide "$(Menu.SideBar.Width)"

      visible 0

      {EXPAND Pin FindAGameButton_anchor $(PIN_TOPRIGHT) $(PIN_TOPRIGHT)}
    }

    // Easier than dealing with hardcoded properties.
    FindAGameButton2
    {
      {EXPAND SideBarButton}

      {INHERIT ../FindAGameButton
        command
        actionSignalLevel
      }

      xPos rs1
      yPos 0

      proportionalToParent 1

      font 9ui.icons.28
      labelText "$(ICON_PLAY)"

      // After a VGUI reload, this color is used initially.
      fgColor "$(./defaultFgColor_override)"
    }

    // Invisible button that covers `FindAGameButton2` when `ExpandableList`
    // is open to make it seem like it toggles `ExpandableList` on and off.
    FindAGameButtonCover
    {
      controlName Button

      xPos 0
      yPos 0
      zPos "$(../FindAGameButton2/zPos + 1)"

      wide f0
      tall f0
      proportionalToParent 0

      command "dimmer_clicked"
      actionSignalLevel "$(../FindAGameButton2/actionSignalLevel)"

      paintBackground 0
      paintBorder 0

      {EXPAND Clicky}

      {EXPAND Pin FindAGameButton $(PIN_BOTTOMLEFT) $(PIN_TOPRIGHT)}
    }

    // Also close `ExpandableList` when clicking anywhere else.
    ClickAwayPanel
    {
      controlName Button

      {EXPAND FillParent}
      zPos -1
      alpha 0

      {INHERIT ../FindAGameButtonCover
        command
        actionSignalLevel
      }
    }
  }
}
