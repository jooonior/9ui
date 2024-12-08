// Matchmaking gamemode list entry.
// ---
// parent: => ./MatchMakingPlaylist.res


"Resource/UI/MainMenuPlayListEntry.res"
{
  {DELETE
    ModeImage
    PlayListDropShadow
    BGColor
    // ToolTipHack
    // ToolTipButtonHack
    // ModeButton
    // MatchmakingBanPanel
    DescLabel
    DescLabelShadow
    // DisabledIcon
  }

  ModeButton
  {
    {EXPAND FlatButton}

    xPos 0
    yPos 0
    wide f0
    tall f0
    proportionalToParent 1

    font 9ui.thick.20
    textAlignment center
    textInsetX 0
    textInsetY 0

    // See `ReturnButton` in `MatchMakingDashboardPlaylist.res` for explanation.
    button_activation_type "$(ACTIVATE_ONRELEASED)"
  }

  // TODO: Tooltips and disabled/banned panels.
}
