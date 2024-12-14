// Same buttons that are on the sidebar => ../../../CompRanksTooltip.res
#base "../../../SideBarButtons.res"

"Resource/UI/StorePanel.res"
{
  store_panel
  {
    paintBackground 0
  }

  {DELETE
    BackgroundHeader
    BackgroundFooter
    FooterLine
  }

  {EXPAND HideFrameChildren}

  // Buttons from `#base ../../../SideBarButtons.res` cover their sidebar
  // counterparts to prevent opening multiple root panels at once.

  {DEFINE SideBarButton} {
    zPos "$(zPos.SideBar + 1)"

    defaultFgColor_override "0 0 0 0"

    // Closes `store_panel`, but also executes `close` engine command.
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

    // Mouse-up registers inside `MainMenuOverride` as another click.
    button_activation_type "$(ACTIVATE_ONPRESSED)"
  }

  Store
  {
    {EXPAND SideBarButton}
  }
}
