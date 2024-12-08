// Main menu root panel. Created on game load.


"Resource/UI/MainMenuOverride.res"
{
  MainMenuOverride
  {
  }

  // ExpandableList => ./MatchMakingDashboardPlaylist.res
  // ExplanationManager => ./GlobalExplanations.res
  // MMDashboard => ./MatchMakingDashboard.res

  {DELETE
    // Background
    TFLogoImage
    // TFCharacterImage
    BackgroundFooter
    FooterLine
    RankBorder
  }

  {EXPAND Hide Background}
  {EXPAND Hide TFCharacterImage}

  {DELETE
    FriendsContainer
  }

  // The actual `DashboardDimmer` panel gets created from code long after
  // `MainMenuOverride` and does not use keys defined here. But after a VGUI
  // reload, these keys are applied to the hardcoded `DashboardDimmer` panel.
  // Before that, this is just an ordinary `MainMenuOverride` child panel.
  DashboardDimmer
  {
    controlName Button  // hardcoded

    alpha 0  // toggled from code

    // VGUI reload applies border from ClientScheme.
    // We can't do anything about it, but we can hide the border.
    paintBorder 0
  }
}
