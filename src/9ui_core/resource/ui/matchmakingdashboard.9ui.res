// Container for matchmaking-related buttons (mostly).
//
// Hardcoded to always move into the currently focused UI root panel. Parent
// reference is not updated when this happens, which lets us run commands inside
// `MainMenuOverride` from other root panels too.
// ---
// parent: MainMenuOverride => ./MainMenuOverride.res
// parent: character_info => ./CharInfoPanel.res


"Resource/UI/MatchMakingDashboard.res"
{
  MMDashboard
  {
    xPos 0
    yPos 0
    zPos "$(zPos.MMDashboard)"
    // Extends off-screen and serves as anchor for `ExpandableList`.
    wide "f-$(ExpandableList.overflow)"
    tall "$(MenuBar.size)"

    // TODO: What are these for?
    collapsed_height 0
    expanded_height "$(./tall)"
    resize_time 0
  }

  TopBar
  {
    xPos 0
    yPos 0
    wide f0
    tall "$(MenuBar.size)"
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
      {EXPAND MenuBarButton}

      xPos rs1
      yPos 0
      proportionalToParent 1

      font 9ui.icons.28
      labelText "$(ICON_PLAY)"

      stay_armed_on_click 0

      {INHERIT ../FindAGameButton
        command  // opens `ExpandableList` => ./MatchMakingDashboardPlaylist.res
        actionSignalLevel
      }

      // After a VGUI reload, this color is used initially.
      fgColor "$(./defaultFgColor_override)"
    }

    ToggleChatButton
    {
      {EXPAND MenuBarButton}

      xPos "r$(ExpandableList.width)"
      yPos 0
      wide o1
      tall f0

      font 9ui.icons.20
      labelText "$(ICON_CHAT)"
    }

    {FOR n BETWEEN 1 5} {
      "PartySlot$(n)"
      {
        xPos 0
        yPos 0
        tall f10
        wide o1

        {EXPAND PinRightTo "PartySlot$(n - 1)"}
      }
    }

    PartySlot1
    {
      {EXPAND PinRightTo ToggleChatButton}
    }

    PartySlot0
    {
      xPos 0
      yPos 0
      tall f6
      wide o1

      {EXPAND PinRightTo PartySlot5}
    }

    Background
    {
      controlName Panel

      zPos -1
      wide f0
      tall f0
      proportionalToParent 0

      bgColor_override _9ui.MenuBar.BG

      mouseInputEnabled 0

      {EXPAND Pin ToggleChatButton "$(PIN_TOPLEFT)" "$(PIN_TOPLEFT)"}
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
