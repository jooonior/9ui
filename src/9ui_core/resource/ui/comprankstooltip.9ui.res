// Tooltip with explanation of competitive ranks.
//
// Hardcoded to always move into the currently focused UI root panel, same as
// `MMDashboard` and other matchmaking panels. Parent reference is not updated
// when this happens, which lets us run commands inside `MainMenuOverride` from
// other root panels too.
//
// Created on game load.
// ---
// parent: MainMenuOverride => ./MainMenuOverride.res


// Sidebar buttons that are also used in other places.
#base "SideBarButtons.res"

"Resource/UI/MatchMakingTooltip.res"
{
  {CLEAR}  // delete everything

  CompRanksTooltip
  {
    controlName CRanksTooltipPanel  // hardcoded

    xPos 0
    yPos 0
    zPos "$(zPos.SideBar)"
    wide "$(MenuBar.size)"
    tall f0
    proportionalToParent 0
  }

  Background
  {
    {EXPAND MenuBarBG}

    wide f0
    tall f0
    proportionalToParent 1
  }

  {DEFINE MainMenuButton} {
    actionSignalLevel 2  // set `MainMenuOverride` as our signal target
  }

  // Buttons from `#base SideBarButtons.res` ...

  Servers
  {
    {EXPAND MainMenuButton}

    command "OpenServerBrowser"
  }

  Backpack
  {
    {EXPAND MainMenuButton}

    command "engine open_charinfo_backpack"

    {EXPAND PinBelow Servers}
  }

  Store
  {
    {EXPAND MainMenuButton}

    command "engine open_store"

    {EXPAND PinBelow Backpack}
  }

  // Other buttons ...

  {DEFINE SmallMainMenuButton} {
    {EXPAND MenuBarButton}
    {EXPAND MainMenuButton}

    wide p0.5
    tall o1
    proportionalToParent 1
  }

  Options
  {
    {EXPAND SmallMainMenuButton}

    font 9ui.icons.14
    labelText "$(ICON_GEAR)"

    command "OpenOptionsDialog"

    {EXPAND Pin Store "$(PIN_TOPLEFT)" "$(PIN_BOTTOMLEFT)"}
  }

  AdvancedOptions
  {
    {EXPAND SmallMainMenuButton}

    font 9ui.icons.18
    labelText "$(ICON_GEARS)"

    command "OpenTF2Options"

    {EXPAND Pin Store "$(PIN_TOPRIGHT)" "$(PIN_BOTTOMRIGHT)"}
  }

  Replays
  {
    {EXPAND SmallMainMenuButton}

    font 9ui.icons.14
    labelText "$(ICON_FILM)"

    command "engine replay_reloadbrowser"

    {EXPAND PinBelow Options}
  }

  Workshop
  {
    {EXPAND SmallMainMenuButton}

    font 9ui.icons.15
    labelText "$(ICON_WRENCH)"

    command "engine OpenSteamWorkshopDialog"

    {EXPAND PinBelow AdvancedOptions}
  }

  Contracker
  {
    {EXPAND SmallMainMenuButton}

    font 9ui.icons.15
    labelText "$(ICON_CONTRACKER)"

    command "questlog"

    {EXPAND PinBelow Replays}
  }

  Achievements
  {
    {EXPAND SmallMainMenuButton}

    font 9ui.icons.16
    labelText "$(ICON_MEDAL)"

    command "OpenAchievementsDialog"

    {EXPAND PinBelow Workshop}
  }

  Quit
  {
    {EXPAND MenuBarButton}
    {EXPAND MainMenuButton}

    yPos rs1

    font 9ui.icons.18
    labelText "$(ICON_QUIT)"

    command "engine quit"
  }
}
