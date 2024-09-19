{PRAGMA FLAGS expand override}

Scheme
{
  Colors
  {
    // Color names must not start with a digit (or a dot).

    _9ui.SideBar.BG "93 93 93 255"

    _9ui.FlatButton.BG.Default "93 93 93 184"
    _9ui.FlatButton.BG.Hover "112 112 112 202"
    _9ui.FlatButton.FG.Default "240 240 240 238"
    _9ui.FlatButton.FG.Hover _9ui.FlatButton.FG.Default

    _9ui.Button.Normal.FG "180 180 180 230"
    _9ui.Button.Hover.FG "219 109 59 220"
  }

  Borders
  {
    9ui_Blush
    {
      bordertype image
      backgroundtype 2
      image "replay/thumbnails/9ui/blush"
    }
  }

  Fonts
  {
    {DEFINE Font name font size} {
      "$(name).$(size)"
      {
        1
        {
          name "$(font)"
          tall "$(size)"
          antialias 1
        }
      }
    }

    {DEFINE FontRange name font} {
      {FOR size BETWEEN 1 128} {
        {EXPAND Font $(name) $(font) $(size)}
      }
    }

    {EXPAND FontRange 9ui.icons 9ui_icons}

    {EXPAND FontRange 9ui.thin Teko}

    {EXPAND FontRange 9ui.thick CocogooseProTrial}
  }

  CustomFontFiles
  {
    9ui_icons
    {
      font "resource/fonts/9ui_icons.ttf"
      name "9ui_icons"
    }

    Teko
    {
      font "resource/fonts/Teko.ttf"
      name "Teko"
    }

    Cocogoose
    {
      font "resource/fonts/Cocogoose-Pro-Regular-trial.ttf"
      name "CocogooseProTrial"
    }
  }
}
