// Main menu root panel. Created on game load.


#base "menusidebars.res"

{PRAGMA FLAGS expand override}

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

    font 9ui.icons.20
    labelText "$(ICON_GLOBE)"

    command "engine gamemenucommand OpenServerBrowser"

    {EXPAND PinOverTopOf SideBar.Right}
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

    {EXPAND PinOverBottomOf SideBar.Right}
  }

  FriendsContainer
  {
    {CLEAR}

    controlName EditablePanel

    xPos 0
    yPos 80
    zPos $(zPos.MainMenu)

    wide $(Menu.SideBar.Width)
    tall 200

    SteamFriendsList
    {
      controlName CSteamFriendsListPanel

      xPos 0
      yPos 0

      wide f0
      tall f0
      proportionalToParent 1

      {DEFINE gap} 2

      columns_count 1
      inset_x $(gap)
      inset_y 0
      row_gap $(gap)
      column_gap 0
      restrict_width 0

      // Template for list entries.
      friendpanel_kv
      {
        wide "f$(gap * 2)"
        tall o1.23
        proportionalToParent 1

        // => ./SteamFriendPanel.res
      }

      ScrollBar
      {
        controlName ScrollBar

        // The is a small margin around the Slider which I can't get rid off.
        // So instead we shift the whole ScrollBar off-screen by a bit.
        xPos -1
        yPos 0

        wide 3
        tall f0
        proportionalToParent 1

        noButtons 1

        Slider
        {
          fgColor_override "255 0 0 255"
        }
      }
    }
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
