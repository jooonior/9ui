// MISC

{DEFINE Hide key} {
  "$(key)"
  {
    xPos r0
    yPos r0
    wide 0
    tall 0
    proportionalToParent 1
    visible 0
    enabled 0
  }
}

{DEFINE FillParent} {
  xPos 0
  yPos 0
  wide f0
  tall f0
  proportionalToParent 1
}

{DEFINE Anchor} {
  controlName Panel
  wide 0
  tall 0
  mouseInputEnabled 0
  keyboardInputEnabled 0
}

// Hide hardcoded children of `Frame`.
{DEFINE HideFrameChildren} {
  {FOR child IN
    topGrip
    bottomGrip
    leftGrip
    rightGrip
    tlGrip
    trGrip
    blGrip
    brGrip
    caption
    minimize
    maximize
    mintosystray
    close
    menu
  } {
    "frame_$(child)" { visible 0 }
  }
}

// PINS

{DEFINE Pin anchor corner sibling_corner} {
  pin_to_sibling "$(anchor)"
  pin_corner_to_sibling "$(corner)"
  pin_to_sibling_corner "$(sibling_corner)"
}

{DEFINE PinAbove anchor} {
  pin_to_sibling "$(anchor)"
  pin_corner_to_sibling "$(PIN_CENTER_BOTTOM)"
  pin_to_sibling_corner "$(PIN_CENTER_TOP)"
}

{DEFINE PinBelow anchor} {
  pin_to_sibling "$(anchor)"
  pin_corner_to_sibling "$(PIN_CENTER_TOP)"
  pin_to_sibling_corner "$(PIN_CENTER_BOTTOM)"
}

{DEFINE PinLeftTo anchor} {
  pin_to_sibling "$(anchor)"
  pin_corner_to_sibling "$(PIN_CENTER_RIGHT)"
  pin_to_sibling_corner "$(PIN_CENTER_LEFT)"
}

{DEFINE PinRightTo anchor} {
  pin_to_sibling "$(anchor)"
  pin_corner_to_sibling "$(PIN_CENTER_LEFT)"
  pin_to_sibling_corner "$(PIN_CENTER_RIGHT)"
}

{DEFINE PinOverTopOf anchor} {
  pin_to_sibling "$(anchor)"
  pin_corner_to_sibling "$(PIN_CENTER_TOP)"
  pin_to_sibling_corner "$(PIN_CENTER_TOP)"
}

{DEFINE PinOverBottomOf anchor} {
  pin_to_sibling "$(anchor)"
  pin_corner_to_sibling "$(PIN_CENTER_BOTTOM)"
  pin_to_sibling_corner "$(PIN_CENTER_BOTTOM)"
}

{DEFINE PinOverLeftOf anchor} {
  pin_to_sibling "$(anchor)"
  pin_corner_to_sibling "$(PIN_CENTER_LEFT)"
  pin_to_sibling_corner "$(PIN_CENTER_LEFT)"
}

{DEFINE PinOverRightOf anchor} {
  pin_to_sibling "$(anchor)"
  pin_corner_to_sibling "$(PIN_CENTER_RIGHT)"
  pin_to_sibling_corner "$(PIN_CENTER_RIGHT)"
}

// BUTTONS

{DEFINE BaseButton} {
  controlName CExButton

  paintBorder 0
  paintBackground 0

  textAlignment center

  stay_armed_on_click 1

  sound_depressed "ui/buttonclick.wav"
  sound_released "ui/buttonclickrelease.wav"
}

{DEFINE FlatButton} {
  {EXPAND BaseButton}

  paintBackground 1
  paintBackgroundType 0
  roundedCorners 0

  defaultBgColor_override _9ui.FlatButton.BG.Default
  armedBgColor_override _9ui.FlatButton.BG.Hover
  depressedBgColor_override _9ui.FlatButton.BG.Hover

  defaultFgColor_override _9ui.FlatButton.FG.Default
  armedFgColor_override _9ui.FlatButton.FG.Hover
  depressedFgColor_override _9ui.FlatButton.BG.Hover
}

{DEFINE MenuBarButton} {
  {EXPAND BaseButton}

  xPos 0
  yPos 0

  wide "$(MenuBar.size)"
  tall o1

  defaultFgColor_override _9ui.Button.Normal.FG
  armedFgColor_override _9ui.Button.Hover.FG
  depressedFgColor_override _9ui.Button.Hover.FG
}

{DEFINE MenuBarBG} {
  controlName EditablePanel

  zPos -1

  mouseInputEnabled 0
  keyboardInputEnabled 0

  Image
  {
    controlName Panel

    xPos cs-0.5
    yPos cs-0.5
    wide "f$(MenuBar.inset)"
    tall "f$(MenuBar.inset)"
    proportionalToParent 1

    paintBackgroundType 2  // needed for `roundedCorners`
    roundedCorners "$(ROUND_CORNER_ALL)"

    bgColor_override _9ui.MenuBar.BG
  }
}
