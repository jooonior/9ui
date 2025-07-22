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

    // Following buttons have their position set from code, calculated respective
    // of each other's size and position, similar to them being pinned.
    //
    // In game:     ResumeButton<-FindAGameButton<-DisconnectButton<-|
    // In menu:                         FindAGameButton<-QuitButton<-|
    //
    // We exploit this to simulate OnlyInGame/OnlyInMenu behavior. Since widths
    // of `QuitButton` and `DisconnectButton` differ, `FindAGameButton` changes
    // its position depending on which one of them is visible.

    // In-game "anchor" for `FindAGameButton`.
    DisconnectButton
    {
      wide 0  // let `FindAGameButton` stay on-screen
      tall 0

      mouseInputEnabled 0
      keyboardInputEnabled 0
    }

    // In-menu "anchor" for `FindAGameButton`.
    QuitButton
    {
      wide f0  // push `FindAGameButton` off-screen
      tall 0

      mouseInputEnabled 0
      keyboardInputEnabled 0
    }

    // The code appears to leave 1-pixel gaps between the buttons. This anchor
    // offsets `FindAGameButton` by one pixel which cancels it out.
    FindAGameButton_Anchor
    {
      controlName Label

      xPos 0
      yPos 0

      // This is how you make a 1 pixel wide panel.
      auto_wide_tocontents 1  // width calculated based on text with and inset
      labelText ""
      textInsetX 1  // 1 pixel
    }

    {MOVE FindAGameButton}  // move after anchor

    FindAGameButton
    {
      {CLEAR
        xPos
        yPos

        command
        actionSignalLevel
      }

      wide f0
      tall 0

      mouseInputEnabled 0
      keyboardInputEnabled 0

      // Align ourselves with screen edges by moving 1 pixel to the right.
      {EXPAND Pin FindAGameButton_Anchor "$(PIN_TOPLEFT)" "$(PIN_TOPRIGHT)"}
    }

    // Not used for anything.
    {EXPAND Hide ResumeButton}

    // Anchor for in-game-only panels.
    OnlyInGame
    {
      controlName Panel

      wide f0
      tall f0
      proportionalToParent 1

      // Pinned over `FindAGameButton`.
      {EXPAND Pin FindAGameButton "$(PIN_TOPLEFT)" "$(PIN_TOPLEFT)"}
    }

    // Anchor for in-menu-only panels.
    OnlyInMenu
    {
      controlName Panel

      wide f0
      tall f0
      proportionalToParent 1

      // Pinned right to `FindAGameButton`.
      {EXPAND Pin FindAGameButton "$(PIN_TOPLEFT)" "$(PIN_TOPRIGHT)"}
    }

    {DEFINE MainMenuButton} {
      {EXPAND MenuBarButton}

      tall f0
      proportionalToParent 1

      // After VGUI reload, this color is used initially (until button is hovered). 
      fgColor "$(./defaultFgColor_override)"

      actionSignalLevel 3  // set `MainMenuOverride` as our signal target
    }

    OnlyInGameBG
    {
      {EXPAND MenuBarBG}

      xPos "$(- MenuBar.size * 1.4 | 0)"
      yPos 0
      wide "$(MenuBar.size * 3)"
      tall f0
      proportionalToParent 1

      {EXPAND Pin OnlyInGame "$(PIN_TOPLEFT)" "$(PIN_TOPLEFT)"}
    }

    LeaveButton
    {
      {EXPAND MainMenuButton}

      {EXPAND Pin OnlyInGameBG "$(PIN_TOPLEFT)" "$(PIN_TOPLEFT)"}

      font 9ui.icons.26
      labelText "$(ICON_EXIT)"

      // Use the matchmaking disconnect command that also leaves the MM lobby.
      {INHERIT ../DisconnectButton
        command
        actionSignalLevel
      }
    }

    CallVoteButton
    {
      {EXPAND MainMenuButton}

      labelText "vote"
      command "callvote"

      font 9ui.icons.22
      labelText "$(ICON_VOTE)"

      {EXPAND PinRightTo LeaveButton}
    }

    MuteButton
    {
      {EXPAND MainMenuButton}

      labelText "mute"
      command "OpenMutePlayerDialog"

      font 9ui.icons.23
      labelText "$(ICON_MUTE)"

      {EXPAND PinRightTo CallVoteButton}
    }

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

      // After a VGUI reload, this color is used initially.
      fgColor "$(./defaultFgColor_override)"
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

    MatchmakingBG
    {
      {EXPAND MenuBarBG}

      wide f0
      tall f0
      proportionalToParent 1

      {EXPAND Pin ToggleChatButton "$(PIN_TOPLEFT)" "$(PIN_TOPLEFT)"}

      Image
      {
        // Extend background to the edge of `ToggleChatButton`.
        xPos 0
      }
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
