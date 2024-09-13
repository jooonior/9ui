local ffi = require "ffi"

-- FFI definitions.
require "9ui_devtools.engine.IFileSystem"


---@type table<string, unknown>
local interfaces = {
  fs = ffi.cast("IFileSystem *", nil),
}

local versions = {
  [interfaces.fs] = "VFileSystem022",
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
M = setmetatable(M, { __index = interfaces })

return M
