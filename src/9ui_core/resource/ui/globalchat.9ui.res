"Resource/UI/GlobalChat.res"
{
  partychat
  {
    // yPos hardcoded 10 units above the bottom of `MMDashboard`.
    // https://github.com/ValveSoftware/source-sdk-2013/blob/39f6dde8/src/game/client/tf/vgui/tf_matchmaking_dashboard.cpp#L571
    // To get around this, we pin to top of `MMDashboard`.
    xPos "$(-1 * ExpandableList.overflow - ExpandableList.width - MenuBar.inset)"
    yPos 0
    zPos "$(zPos.MMSidePanel)"

    tall 194  // `chatlog` height is hardcoded relative to this
    wide 200

    paintBorder 0
    paintBackground 0

    collapsed_height 0
		expanded_height "$(./tall + 5)"  // overrides tall

    // `chatlog` is hardcoded to use these fonts.
    log_font_small 9ui.regular.10
    log_font_medium 9ui.regular.10
    log_font_large 9ui.regular.10

    {EXPAND Pin MMDashboard "$(PIN_TOPRIGHT)" "$(PIN_TOPRIGHT)"}
  }

  chatlog_Anchor
  {
    {EXPAND Anchor}
    yPos 10
  }

  {MOVE chatlog}

  chatlog
  {
    xPos 0
    yPos 5  // don't change!

    // Height is set from code. Changing yPos breaks animations.

    // Because of our positioning, the first line of text is off-screen.
    // This dummy text makes chat messages start at the second line.
    text " "

    pin_to_sibling chatlog_Anchor
    // Pin direction matters! Pin to top reverses slide animation direction.
    pin_to_sibling_corner "$(PIN_BOTTOMLEFT)"

    // Uses `RichText.BgColor` from ClientScheme.
    paintBackground 0
    paintBorder 0
  }

  {MOVE chatentry}

  chatentry
  {
    xPos 0
    yPos -5
    wide f0
    tall 16

    // Transparency doesn't work. Probably because it's a popup?

    paintBackground 1
    paintBackgroundType 2  // needed for `roundedCorners`
    roundedCorners "$(ROUND_CORNER_BOTTOM_LEFT | ROUND_CORNER_BOTTOM_RIGHT)"
    bgColor_override _9ui.Panel.Opaque

    paintBorder 0

    font 9ui.regular.11

    {EXPAND PinBelow chatlog}
  }

  {DELETE EntryShadow}

  Background
  {
    controlName Panel
    visible 1
    wide f0
    tall f0
    proportionalToParent 1

    paintBackground 1
    bgColor_override _9ui.Panel.Opaque

    {EXPAND PinAbove chatentry}
  }
}
