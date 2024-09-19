{PRAGMA FLAGS expand override}

"Resource/UI/MatchMakingDashboardSidePanel.res"
{
  {DELETE
    Shade
    TitleGradient
    InnerGradient
    OuterGradient
    BGPanel
  }

  // These get created from code.
  Shade { visible 0 }
  InnerGradient { visible 0 }

  // Imitates hover effect of `MMDashboard > TopBar > PlayButton`, which gets
  // covered up by the side panel when it expands.
  FakePlayButton
  {
    {EXPAND PlayButton}

    xPos "$(ExpandableList.Width)-s1"
    yPos 0
    proportionalToParent 1

    font 9ui.icons.28
    labelText "$(ICON_PLAY)"

    command "nav_close"  // close all side panels

    // Should be visible only when hovered.
    defaultFgColor_override "0 0 0 0"
  }
}
