// Steam friend list entry.
// ---
// parent: friendpanel_kv => ./MainMenuOverride.res


{PRAGMA FLAGS expand override}

"Resource/UI/SteamFriendPanel.res"
{
  avatar
  {
    xPos 0
    yPos 0
    zPos 0
    wide f0
    tall o1
    proportionalToParent 1
  }

  InteractButton
  {
    xPos 0
    yPos 0
    zPos 3
    wide f0
    tall f0
    proportionalToParent 1

    border_default NoBorder
  }

  NameLabel
  {
    xPos 0
    yPos -1
    zPos 2
    wide f1  // small padding around text
    tall f0
    proportionalToParent 1

    font 9ui.thin.12
    textAlignment north
    wrap 0
    labelText "%name%"

    {EXPAND PinBelow avatar}
  }

  StatusLabel
  {
    xPos 0
    yPos 0
    zPos 1
    wide f0
    tall f0
    proportionalToParent 1

    font 9ui.icons.127
    textAlignment north
    // Text consisting of full-width that serves as a solid background.
    labelText "$(ICON_BLOCK)$(ICON_BLOCK)$(ICON_BLOCK)$(ICON_BLOCK)"

    {EXPAND PinBelow avatar}
  }
}
