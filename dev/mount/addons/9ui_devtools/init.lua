local ffi = require "ffi"

local glob = require "9ui_devtools.utils.glob"

-- FFI definitions for polymorphic objects.
require "9ui_devtools.ffi.virtual"


-- Engine interfaces.

local IFileSystem = nil

local function connect_interfaces(interface_factory)
  interface_factory = ffi.cast(
    "virtual *(*)(const char *pName, int *pReturnCode)",
    interface_factory
  )

  local function create_interface(version)
    local interface = interface_factory(version, nil)
    if interface == nil then
      error(("interface %s not found"):format(version))
    end
    return interface
  end

  IFileSystem = create_interface("VFileSystem022")
  IFileSystem:__bind(7, [[
    void AddSearchPath(const char *pPath, const char *pathID, int addType)
  ]])
  IFileSystem:__bind(8, [[
    void RemoveSearchPath(const char *pPath, const char *pathID)
  ]])
end


-- Plugin table.

local Plugin = {
  mounted = {}
}


function Plugin:Load(interface_factory)
  connect_interfaces(interface_factory)

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
      IFileSystem:AddSearchPath(path, id, 0)  -- PATH_ADD_TO_HEAD
      table.insert(self.mounted, {path, id})
    end
    print(("[9ui_devtools] mount: %s"):format(path))
  end

  return true
end


function Plugin:Unload()
  if IFileSystem == nil then
    return
  end

  for _, mounted in ipairs(self.mounted) do
    local path, id = unpack(mounted)
    IFileSystem:RemoveSearchPath(path, id)
  end
end


function Plugin:GetPluginDescription()
  return "9ui developer tools"
end


return Plugin
