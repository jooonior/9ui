{PRAGMA FLAGS expand override}

"Resource/UI/MatchMakingDashboard.res"
{
  MMDashboard
  {
    xPos 0
    yPos 0
    zPos $(zPos.MMDashboard)
    // Extends off-screen and serves as anchor for `ExpandableList`.
    wide "f-$(ExpandableList.Overflow)"
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
    tall "$(Menu.SideBar.Width)"
    proportionalToParent 0

    {DELETE
      Gradient
      BGPanel
      OuterShadow
    }

    {FOR button IN
      QuitButton
      DisconnectButton
      ResumeButton
      FindAGameButton
    } {
      {EXPAND Hide "$(button)"}
    }

    // Easier than dealing with hardcoded properties of `FindAGameButton`.
    PlayButton
    {
      {EXPAND PlayButton}

      xPos rs1
      yPos 0
      proportionalToParent 1

      font 9ui.icons.28
      labelText "$(ICON_PLAY)"

      {INHERIT ../FindAGameButton
        command
        actionSignalLevel
      }

      // After a VGUI reload, this color is used initially.
      fgColor "$(./defaultFgColor_override)"
    }

    // Close `ExpandableList` when clicking anywhere else.
    ClickAwayPanel
    {
      controlName Button

      {EXPAND FillParent}
      zPos -1
      alpha 0

      command "dimmer_clicked"  // same as clicking `DashboardDimmer`

      {INHERIT ../FindAGameButton
        actionSignalLevel
      }
    }
  }
}
