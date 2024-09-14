local ffi = require "ffi"

-- FFI definitions.
require "9ui_devtools.engine.ICvar"
require "9ui_devtools.engine.IFileSystem"
require "9ui_devtools.engine.IPanel"
require "9ui_devtools.engine.ISurface"


local interfaces = {
  cvar = ffi.cast("ICvar *", nil),
  fs = ffi.cast("IFileSystem *", nil),
  panel = ffi.cast("IPanel *", nil),
  surface = ffi.cast("ISurface *", nil),
}

local versions = {
  [interfaces.cvar] = "VEngineCvar004",
  [interfaces.fs] = "VFileSystem022",
  [interfaces.panel] = "VGUI_Panel009",
  [interfaces.surface] = "VGUI_Surface030",
}


local M = {}

function M.connect(interface_factory)
  interface_factory = ffi.cast(
    "void *(*)(const char *name, int *returnCode)",
    interface_factory
  )

  for key, value in pairs(interfaces) do
    local version = versions[value]
    local interface = interface_factory(version, nil)

    if interface == nil then
      warn(("interface '%s' not found"):format(version))
    else
      interface = ffi.cast(ffi.typeof(value), interface)
    end

    interfaces[key] = interface
  end
end

-- Make interfaces accessible though the module table.
---@cast interfaces table<string, unknown>
M = setmetatable(M, { __index = interfaces })

return M
