// Base for expandable matchmaking side panels.
// ---
// base: CasualCriteria => ./MatchMakingDashboardCasualCriteria.res
// base: ExpandableList => ./MatchMakingDashboardPlaylist.res


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

  ReturnButton
  {
    // Only visible in `ExpandableList`.
    if_left
    {
      visible 0
    }
  }

  // Closes all side panels when clicking away.
  CloseButton
  {
    {EXPAND FillParent}
    zPos -1
    alpha 0
  }
}
