// Inventory (character info) root panel. Contains all inventory subpanels.
//
// Created on game load. Drawn over main menu.


#base "menusidebars.res"

{PRAGMA FLAGS expand override}

"Resource/UI/CharInfoPanel.res"
{
  character_info
  {
  }

  {DELETE
    BackgroundHeader
    BackgroundFooter
    FooterLine
  }
}
