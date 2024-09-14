local ffi = require "ffi"

local ifc = require "9ui_devtools.interfaces"


local M = {}


function M.get_search_paths(path_id)
  local length = ifc.fs:GetSearchPath(path_id, false, nil, 0)
  local path = ffi.new("char[?]", length)
  ifc.fs:GetSearchPath(path_id, false, path, length)
  return ffi.string(path):gmatch("[^;]+")
end


return M
