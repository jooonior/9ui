// Gamemode selection buttons contained in the side panel that expands when the
// play button is clicked.
//
// parent: playlist => ./MatchMakingDashboardPlaylist.res


"Resource/UI/MatchMakingDashboardCasualCriteria.res"
{
  {DEFINE Entry} {
    xPos 0
    yPos 0

    wide "$(PlaylistEntry.width)"
    tall "$(PlaylistEntry.height)"

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
