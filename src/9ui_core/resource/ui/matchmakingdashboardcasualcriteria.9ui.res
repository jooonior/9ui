// Expandable side panel containing casual map selection.
// ---
// parent: MainMenuOverride => ./MainMenuOverride.res


{PRAGMA FLAGS expand override}

// Stock file contains:
//   #base "MatchMakingDashboardSidePanel.res"

"Resource/UI/MatchMakingDashboardCasualCriteria.res"
{
  CasualCriteria
  {
    xPos r0
    yPos "$(PlaylistEntry.Height)"
    zPos "$(zPos.ExpandableList + 1)"
    wide "$(ExpandableList.OuterWidth)"
  }
}
