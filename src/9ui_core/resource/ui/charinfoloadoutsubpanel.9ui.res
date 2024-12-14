"Resource/UI/CharInfoLoadoutSubPanel.res"
{
  CharInfoLoadoutSubPanel
  {
    paintBackground 0

    // Offsets hardcoded yPos back to zero.
    pin_to_sibling CharInfoLoadoutSubPanel_Anchor  // => ./CharInfoPanel.res
  }

  // Hide class buttons that are created from code.
  {FOR class IN
    scout
    soldier
    pyro
    demoman
    heavyweapons
    engineer
    medic
    sniper
    spy
  } {
    "$(class)"
    {
      visible 0
    }
  }

  // Hide panels that are created and have their visibility set from code.
  {FOR panel IN
    ShowBackpackButton
    ShowCraftingButton
    ShowArmoryButton
    ShowTradeButton
    ShowPaintkitsButton

    ShowBackpackLabel
    ShowCraftingLabel
    ShowArmoryLabel
    ShowTradeLabel
    ShowPaintkitsLabel
  } {
    "$(panel)"
    {
      xPos 0
      yPos 0
      wide 0
      tall 0
    }
  }

  {DELETE
    ShowExplanationsButton
    SelectLabel             // "select class to modify loadout"
    LoadoutChangesLabel     // "changes take effect on respawn"
  }

  // Page properties set here override ones defined in page-specific files.
  {DELETE
    backpack_panel  // => ./econ/BackpackPanel.res
  }
}
