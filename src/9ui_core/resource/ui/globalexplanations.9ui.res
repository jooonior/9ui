{PRAGMA FLAGS expand override}

"Resource/UI/GlobalExplanations.res"
{
  // This panel is repurposed as a gradient that slides across the screen as
  // `DashboardDimmer` appears. This creates an illusion of a opacity
  // transition, which looks close to `DashboardDimmer` fading in/out.
  ExplanationManager
  {
    xPos "$(ExpandableList.Width * -1)"
    yPos 0
    zPos "$(zPos.DashboardDimmer - 1)"

    wide "f-$(ExpandableList.Overflow)"
    tall f0

    mouseInputEnabled 0
    keyboardInputEnabled 0

    {EXPAND Pin ExpandableList $(PIN_BOTTOMRIGHT) $(PIN_BOTTOMLEFT)}
  }

  FakeDashboardDimmer
  {
    controlName EditablePanel

    xPos 0
    yPos rs1
    wide f0
    // tall 60  // off by a few pixels
    tall p0.124  // pixel-perfect
    proportionalToParent 1

    Background_anchor
    {
      controlName Panel

      xPos rs1
      yPos 0
      tall f0
      wide 0
      proportionalToParent 1
    }

    Background
    {
      controlName Panel

      xPos 0
      yPos 0
      wide f0
      tall f0
      proportionalToParent 0

      bgColor_override "0 0 0 230"  // `DashboardDimmer` color

      {EXPAND PinLeftTo Background_anchor}
    }

    // Creates a fade effect as the panel slides across the screen.
    Fade
    {
      controlName ImagePanel

      xPos 0
      yPos 0
      wide "$(ExpandableList.Overflow)"
      tall f0
      proportionalToParent 1

      image "replay/thumbnails/9ui/dashboard_dimmer_fade"
      scaleImage 1

      {EXPAND PinLeftTo Background}
    }
  }

  // Hide all explanation popus.
  {FOR explanation_popup IN
    CasualInto
    CasualLeveling
    CasualCriteria
    CriteriaSaving
    CasualLateJoin
    MapSelectionDetailsExplanation
    CompIntro
    EventPlaceholderIntro
    CompVsCasual
    CompAbandon
    CompDisconnects
    CompCustomHUD
    WarPaintUse
    TutorialHighlight
    PracticeHighlight
    NewUserForumHighlight
    OptionsHighlightPanel
    LoadoutHighlightPanel
    StoreHighlightPanel
    FindAMatch
    SpecialEvents
    SpecialEventsExpiration
  } {
    "$(explanation_popup)"
    {
      xPos 0
      yPos 0
      wide 0
      tall 0

      start_x 0
      start_y 0
      start_wide 0
      start_tall 0

      end_x 0
      end_y 0
      end_wide 0
      end_tall 0

      callout_inparents_x 0
      callout_inparents_y 0
    }
  }
}
