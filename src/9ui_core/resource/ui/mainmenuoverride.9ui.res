// Main menu root panel. Created on game load.


#base "menusidebars.res"

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

  Servers
  {
    {EXPAND SideBarButton}

    font 9ui.icons.26
    labelText "$(ICON_GLOBE)"

    command "engine gamemenucommand OpenServerBrowser"

    {EXPAND PinOverTopOf SideBar.Left}
  }

  Backpack
  {
    {EXPAND SideBarButton}

    font 9ui.icons.20
    labelText "$(ICON_SUITCASE)"

    command "engine open_charinfo"

    {EXPAND PinBelow Servers}
  }

  Store
  {
    {EXPAND SideBarButton}

    font 9ui.icons.22
    labelText "$(ICON_BASKET)"

    command "engine open_store"

    {EXPAND PinBelow Backpack}
  }

  Settings
  {
    {EXPAND SideBarButton}

    font 9ui.icons.21
    labelText "$(ICON_GEAR)"

    command "OpenOptionsDialog"

    {EXPAND PinBelow Store}
  }

  Quit
  {
    {EXPAND SideBarButton}

    font 9ui.icons.18
    labelText "$(ICON_QUIT)"

    command "engine quit"

    {EXPAND PinOverBottomOf SideBar.Left}
  }

  {DELETE
    FriendsContainer
  }

  // The actual `DashboardDimmer` panel gets created from code long after
  // `MainMenuOverride` and does not use keys defined here. But after a VGUI
  // reload, these keys are applied to the hardcoded `DashboardDimmer` panel.
  DashboardDimmer
  {
    controlName Button  // hardcoded

    // VGUI reload applies border from ClientScheme.
    // We can't do anything about it, but we can hide the border.
    paintBorder 0
  }
}
