local ffi = require "ffi"

require "9ui_devtools.globals"

local glob = require "9ui_devtools.utils.glob"
local ifc = require "9ui_devtools.interfaces"



-- Plugin table.

local Plugin = {
  mounted = {},
}


function Plugin:Load(interface_factory)
  ifc.connect(interface_factory)

  if ifc.fs == nil then
    return false
  end

  local pattern = ("dev/mount/addons/9ui_devtools/init.lua"):gsub("/", "[\\/]")
  local build_directory = string.gsub(arg[0], pattern .. "$", "build/")

  local directories_to_mount = {}

  for filename in glob(build_directory .. "*") do
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

  return true
end


function Plugin:Unload()
  for _, mounted in ipairs(self.mounted) do
    local path, id = unpack(mounted)
    ifc.fs:RemoveSearchPath(path, id)
  end
end


function Plugin:GetPluginDescription()
  return "9ui developer tools"
end


return Plugin
