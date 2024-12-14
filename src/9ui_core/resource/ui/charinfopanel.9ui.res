// Inventory (character info) root panel. Contains all inventory subpanels.
//
// Created on game load. Drawn over main menu.


// Same buttons that are on the sidebar => ./CompRanksTooltip.res
#base "SideBarButtons.res"

"Resource/UI/CharInfoPanel.res"
{
  character_info
  {
    // Bugged, makes `Sheet` yPos depend on uninitialized memory.
    // setTitleBarVisible 0

    // `Sheet` position and size is hardcoded like so:
    //
    // xPos = character_info.clientInsetX_override
    // yPos = Frame.ClientInsetY                     // from clientscheme
    //      + character_info.titleTextInsetY
    //      + height of `character_info.title_font`  // in pixels
    //      + 8
    // tall = character_info.tall                    // computed value in pixels
    //      - Frame.ClientInsetY                     // from clientscheme
    //      - character_info.titleTextInsetY
    //      - Sheet.yPos                             // computed value in pixels
    //      - character_info.sheetInset_bottom
    // wide = character_info.wide                    // computed value in pixels
    //      - character_info.clientInsetX_override
    //      - Sheet.xPos                             // computed value in pixels
    //
    // ^ taken from `PropertyDialog::PerformLayout` and `Frame::GetClientArea`.

    // Cancels out the `Frame.ClientInsetY + 8` part of the yPos equation above.
    titleTextInsetY "$(- 6 - 8)"

    // Somehow, `Sheet` still sits one pixel too high. This font, made to be
    // one pixel tall, pushes `Sheet` into the correct position.
    title_font 9ui.blank

    // Adjusts `Sheet` height to match parent.
    sheetInset_bottom 8
  }

  {DELETE
    BackgroundHeader
    BackgroundFooter
    FooterLine
    BackButton
  }

  {EXPAND HideFrameChildren}

  Sheet
  {
    // xPos, yPos, wide, tall hardcoded based on `character_info` properties.

    {DELETE
      HeaderLine
      tabskv
    }

    // Hide the tabs.
    tabHeight 0

    // Pages' yPos is set from code. This offsets them back to zero.
    CharInfoLoadoutSubPanel_Anchor
    {
      {EXPAND Anchor}
      yPos 14
    }

    // CharInfoLoadoutSubPanel => ./CharInfoLoadoutSubPanel.res
    // TFStatsSummary => ./StatSummary_Embedded.res
  }

  // Buttons from `#base SideBarButtons.res` cover their sidebar counterparts
  // to prevent opening multiple root panels at once.

  {DEFINE SideBarButton} {
    zPos "$(zPos.SideBar + 1)"

    // Keep only hover colors. The button underneath is still visible.
    defaultFgColor_override "0 0 0 0"

    // Closes `character_info`, but also executes `close` engine command.
    // Such command doesn't exist, which prints an "unknown command" message.
    command "Close"
  }

  Servers
  {
    visible 0
  }

  Backpack
  {
    {EXPAND SideBarButton}
  }

  Store
  {
    {EXPAND SideBarButton}

    // Mouse-up registers inside `MainMenuOverride` as another click.
    button_activation_type "$(ACTIVATE_ONPRESSED)"
  }
}
