{PRAGMA FLAGS expand override}

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
    xPos 0
    yPos 0
    wide f0
    tall f0
    proportionalToParent 1

    paintBackground 1
    paintBorder 0
    roundedCorners 0

    defaultBgColor_override _9ui.FlatButton.BG.Default
    armedBgColor_override _9ui.FlatButton.BG.Hover

    font 9ui.thick.20
    textAlignment center
    textInsetX 0
    textInsetY 0

    defaultFgColor_override _9ui.FlatButton.FG.Default
    armedFgColor_override _9ui.FlatButton.FG.Hover

    // See `ReturnButton` in `MatchMakingDashboardPlaylist.res` for explanation.
    button_activation_type "$(ACTIVATE_ONRELEASED)"
  }

  // TODO: Tooltips and disabled/banned panels.
}
