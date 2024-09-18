// MISC

{DEFINE Hide key} {
  $(key)
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

// PINS

{DEFINE Pin anchor corner sibling_corner} {
  pin_to_sibling $(anchor)
  pin_corner_to_sibling $(corner)
  pin_to_sibling_corner $(sibling_corner)
}

{DEFINE PinAbove anchor} {
  pin_to_sibling $(anchor)
  pin_corner_to_sibling $(PIN_CENTER_BOTTOM)
  pin_to_sibling_corner $(PIN_CENTER_TOP)
}

{DEFINE PinBelow anchor} {
  pin_to_sibling $(anchor)
  pin_corner_to_sibling $(PIN_CENTER_TOP)
  pin_to_sibling_corner $(PIN_CENTER_BOTTOM)
}

{DEFINE PinLeftTo anchor} {
  pin_to_sibling $(anchor)
  pin_corner_to_sibling $(PIN_CENTER_RIGHT)
  pin_to_sibling_corner $(PIN_CENTER_LEFT)
}

{DEFINE PinRightTo anchor} {
  pin_to_sibling $(anchor)
  pin_corner_to_sibling $(PIN_CENTER_LEFT)
  pin_to_sibling_corner $(PIN_CENTER_RIGHT)
}

{DEFINE PinOverTopOf anchor} {
  pin_to_sibling $(anchor)
  pin_corner_to_sibling $(PIN_CENTER_TOP)
  pin_to_sibling_corner $(PIN_CENTER_TOP)
}

{DEFINE PinOverBottomOf anchor} {
  pin_to_sibling $(anchor)
  pin_corner_to_sibling $(PIN_CENTER_BOTTOM)
  pin_to_sibling_corner $(PIN_CENTER_BOTTOM)
}

{DEFINE PinOverLeftOf anchor} {
  pin_to_sibling $(anchor)
  pin_corner_to_sibling $(PIN_CENTER_LEFT)
  pin_to_sibling_corner $(PIN_CENTER_LEFT)
}

{DEFINE PinOverLeftOf anchor} {
  pin_to_sibling $(anchor)
  pin_corner_to_sibling $(PIN_CENTER_RIGHT)
  pin_to_sibling_corner $(PIN_CENTER_RIGHT)
}

// BUTTONS

{DEFINE Clicky} {
  sound_depressed "ui/buttonclick.wav"
  sound_released "ui/buttonclickrelease.wav"
}

{DEFINE FlatButton} {
  controlName CExButton

  wide o1
  tall o1

  paintBackground 0
  paintBorder 0

  textAlignment center

  {EXPAND Clicky}
}

{DEFINE SideBarButton} {
  {EXPAND FlatButton}

  xPos 0
  yPos 0
  zPos $(zPos.MainMenu)

  wide $(Menu.SideBar.Width)

  defaultFgColor_override "_9ui.Button.Normal.FG"
  armedFgColor_override "_9ui.Button.Hover.FG"
  depressedFgColor_override "_9ui.Button.Hover.FG"
}
