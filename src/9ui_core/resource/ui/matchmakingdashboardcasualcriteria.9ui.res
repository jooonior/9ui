// Expandable side panel containing casual map selection.
// ---
// parent: MainMenuOverride => ./MainMenuOverride.res


// Stock file contains:
//   #base "MatchMakingDashboardSidePanel.res"

"Resource/UI/MatchMakingDashboardCasualCriteria.res"
{
  CasualCriteria
  {
    xPos r0
    yPos "$(MenuBar.size + PlaylistEntry.height)"
    zPos "$(zPos.MMSidePanel)"
    wide "$(ExpandableList.width)"
    tall "f$(./yPos + 60)"
  }
}
