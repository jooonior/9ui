{PRAGMA FLAGS expand override}

"Resource/UI/MatchMakingDashboardCasualCriteria.res"
{
  {DEFINE Entry} {
    xPos 0
    yPos 0

    // For some reason, relative sizes are way smaller than thay should be.
    wide 100
    tall $(Menu.SideBar.Width)

    proportionalToParent 0
  }

  CasualEntry
  {
    {EXPAND Entry}
  }

  CompetitiveEntry
  {
    {EXPAND Entry}
    {EXPAND PinRightTo CasualEntry}
  }

  MvMEntry
  {
    {EXPAND Entry}
    {EXPAND PinRightTo CompetitiveEntry}
  }
}
