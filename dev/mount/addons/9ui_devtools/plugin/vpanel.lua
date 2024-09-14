local ffi = require "ffi"

local engine = require "9ui_devtools.engine"
local ifc = require "9ui_devtools.interfaces"


local M = {}


local function find_panel_rec(root, name, ...)
  if name == nil then
    return root
  end

  local root_name = ffi.string(ifc.panel:GetName(root))
  if root_name == name then
    return find_panel_rec(root, ...)
  end

  for i = 0, ifc.panel:GetChildCount(root) - 1 do
    local child = ifc.panel:GetChild(root, i)
    local found = find_panel_rec(child, name, ...)
    if found ~= nil then
      return found
    end
  end

  return nil
end

---Find panel by name or path.
---@param ... string Panel names leading from VGUI root to the target panel.
---@return ffi.cdata*|nil VPANEL
function M.find_panel(...)
  local root = ifc.surface:GetEmbeddedPanel()

  return find_panel_rec(root, ...)
end


---Print panel settings to console.
---@param handle ffi.cdata* VPANEL handle
function M.print_panel_settings(handle)
  local panel = ifc.panel:GetPanel(handle, "ClientDLL")

  local name = ffi.string(ifc.panel:GetName(handle))
  local keyvalues = engine.KeyValues(name)

  panel:GetSettings(keyvalues)
  keyvalues:Dump()
end


return M
