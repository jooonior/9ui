{PRAGMA FLAGS expand override}

"Resource/UI/MatchMakingDashboardCasualCriteria.res"
{
  {DEFINE Entry} {
    xPos 0
    yPos 0

    wide "$(PlaylistEntry.Width)"
    tall "$(PlaylistEntry.Height)"

    // Looks like parent does not resolve properly and sizes end up wrong.
    proportionalToParent 0
  }

  CasualEntry
  {
    {EXPAND Entry}
    // Looks like these only work with localized strings.
    button_token "#9ui_PlaylistButton_Casual"
  }

  CompetitiveEntry
  {
    {EXPAND Entry}
    button_token "#9ui_PlaylistButton_Comp"

    {EXPAND PinRightTo CasualEntry}
  }

  MvMEntry
  {
    {EXPAND Entry}
    button_token "#9ui_PlaylistButton_MvM"

    {EXPAND PinRightTo CompetitiveEntry}
  }
}
