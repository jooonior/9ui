local ffi = require "ffi"

local engine = require "9ui_devtools.engine"
local ifc = require "9ui_devtools.interfaces"
local utils = require "9ui_devtools.utils"


local M = {}


local function find_topmost_panel(root, name)
  local root_name = ffi.string(ifc.panel:GetName(root))
  if root_name == name then
    return root
  end

  -- BFS for panel with matching name.
  local q = utils.deque.new()
  q:push_right(root)

  while not q:empty() do
    local parent = q:pop_left()

    for i = 0, ifc.panel:GetChildCount(parent) - 1 do
      local child = ifc.panel:GetChild(parent, i)
      local child_name = ffi.string(ifc.panel:GetName(child))

      if child_name == name then
        return child
      end

      q:push_right(child)
    end
  end

  return nil
end

---Find panel by name or path.
---@param ... string Panel names leading from VGUI root to the target panel.
---@return ffi.cdata*|nil VPANEL
function M.find_panel(...)
  local root = ifc.surface:GetEmbeddedPanel()

  for _, name in ipairs({...}) do
    if root == nil then
      return nil
    end
    root = find_topmost_panel(root, name)
  end

  return root
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
