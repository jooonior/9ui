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


"Resource/UI/MatchMakingTooltip.res"
{
  {CLEAR}  // delete everything

  CompRanksTooltip
  {
    controlName CRanksTooltipPanel  // hardcoded

    xPos 0
    yPos 0
    zPos "$(zPos.MainMenu)"
    wide "$(Menu.SideBar.Width)"
    tall f0
    proportionalToParent 0
  }

  Background
  {
    controlName Panel

    zPos -1
    wide f0
    tall f0
    proportionalToParent 1

    bgColor_override _9ui.SideBar.BG

    mouseInputEnabled 0
  }

  {DEFINE MainMenuButton} {
    {EXPAND SideBarButton}

    wide f0
    tall o1
    proportionalToParent 1

    actionSignalLevel 2  // set `MainMenuOverride` as our signal target
  }

  Servers
  {
    {EXPAND MainMenuButton}

    font 9ui.icons.26
    labelText "$(ICON_GLOBE)"

    command "OpenServerBrowser"
  }

  Backpack
  {
    {EXPAND MainMenuButton}

    font 9ui.icons.20
    labelText "$(ICON_SUITCASE)"

    command "engine open_charinfo_backpack"

    {EXPAND PinBelow Servers}
  }

  Store
  {
    {EXPAND MainMenuButton}

    font 9ui.icons.22
    labelText "$(ICON_BASKET)"

    command "engine open_store"

    {EXPAND PinBelow Backpack}
  }

  Quit
  {
    {EXPAND MainMenuButton}

    yPos rs1

    font 9ui.icons.18
    labelText "$(ICON_QUIT)"

    command "engine quit"
  }
}
