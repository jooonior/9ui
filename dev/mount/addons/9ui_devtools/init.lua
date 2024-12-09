local ffi = require "ffi"

require "9ui_devtools.globals"

local engine = require "9ui_devtools.engine"
local ifc = require "9ui_devtools.interfaces"
local plugin = require "9ui_devtools.plugin"
local utils = require "9ui_devtools.utils"


-- Plugin table.

local Plugin = {
  mounted = {},
  commands = {},
}


function Plugin:Load(interface_factory)
  ifc.connect(interface_factory)

  if ifc.fs == nil or ifc.basefs == nil then
    return false
  end

  -- Unmount custom HUDs.
  for path in plugin.path.get_search_paths("custom_mod") do
    if ifc.basefs:FileExists(path .. "/info.vdf", nil) then
      for _, id in ipairs {"game", "mod", "custom_mod"} do
        ifc.fs:RemoveSearchPath(path, id)
      end
      print(("[9ui_devtools] unmount: %s"):format(path))
    end
  end

  local pattern = ("dev/mount/addons/9ui_devtools/init.lua"):gsub("/", "[\\/]")
  local build_directory = string.gsub(arg[0], pattern .. "$", "build/")

  local directories_to_mount = {}

  for filename in utils.glob(build_directory .. "*") do
    if filename:match("[\\/]$") then
      local directory = (build_directory .. filename):gsub("\\", "/")
      table.insert(directories_to_mount, directory)
    end
  end

  -- Prepend directories to path in reverse order.
  for i = #directories_to_mount, 1, -1 do
    local path = directories_to_mount[i]
    for _, id in ipairs {"custom_mod", "mod", "game"} do
      ifc.fs:AddSearchPath(path, id, 0)  -- PATH_ADD_TO_HEAD
      table.insert(self.mounted, {path, id})
    end
    print(("[9ui_devtools] mount: %s"):format(path))
  end

  if ifc.cvar ~= nil then

    if ifc.panel ~= nil and ifc.surface ~= nil then

      local vpanel_dump_settings = engine.ConCommand {
        name = "vpanel_dump_settings",
        description = "Print VGUI panel settings to console.",
        callback = function(args)
          if args:ArgC() < 2 then
            warn("usage: vpanel_dump_settings <panel name> ...")
            return
          end

          local names = {}
          for i = 1, args:ArgC() - 1 do
            table.insert(names, args:Arg(i))
          end

          local panel = plugin.vpanel.find_panel(unpack(names))
          if panel == nil then
            print("panel not found")
          else
            plugin.vpanel.print_panel_settings(panel)
          end
        end,
      }
      if vpanel_dump_settings ~= nil then
        ifc.cvar:RegisterConCommand(vpanel_dump_settings)
        table.insert(self.commands, vpanel_dump_settings)
      end

      local vpanel_get_parent = engine.ConCommand {
        name = "vpanel_get_parent",
        description = "Get the parent of a VGUI panel.",
        callback = function(args)
          if args:ArgC() < 2 then
            warn("usage: vpanel_get_parent <panel name> ...")
            return
          end

          local names = {}
          for i = 1, args:ArgC() - 1 do
            table.insert(names, args:Arg(i))
          end

          local panel = plugin.vpanel.find_panel(unpack(names))
          if panel == nil then
            print("panel not found")
          else
            local parent = ifc.panel:GetParent(panel)
            local name = ifc.panel:GetName(parent)
            print(ffi.string(name))
          end
        end,
      }
      if vpanel_get_parent ~= nil then
        ifc.cvar:RegisterConCommand(vpanel_get_parent)
        table.insert(self.commands, vpanel_get_parent)
      end

    end

  end

  return true
end


function Plugin:Unload()
  for _, mounted in ipairs(self.mounted) do
    local path, id = unpack(mounted)
    ifc.fs:RemoveSearchPath(path, id)
  end

  for _, command in ipairs(self.commands) do
    ifc.cvar:UnregisterConCommand(command)
  end
end


function Plugin:GetPluginDescription()
  return "9ui developer tools"
end


return Plugin
